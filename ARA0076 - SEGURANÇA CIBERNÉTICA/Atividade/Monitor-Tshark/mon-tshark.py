import subprocess
import re
from rich.console import Console
from rich.table import Table
from rich import box
from rich.live import Live
from datetime import datetime
import os

console = Console()

def monitorar_rede(interface="eth0"):
    # Configuração do arquivo de log
    data_atual = datetime.now().strftime("%d-%m-%Y")
    nome_arquivo_log = f"logs/{data_atual}.log"
    os.makedirs("logs", exist_ok=True)

    def escrever_log(mensagem):
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        with open(nome_arquivo_log, "a") as log_file:
            log_file.write(f"[{timestamp}] {mensagem}\n")

    # Comando tshark
    cmd = [
        "tshark",
        "-i", interface,
        "-l",  # Saída em tempo real
        "-T", "fields",
        "-e", "frame.protocols",
        "-e", "ip.src",
        "-e", "ip.dst",
        "-e", "tcp.srcport",
        "-e", "tcp.dstport",
        "-e", "_ws.col.Info"
    ]

    # Palavras-chave suspeitas
    palavras_suspeitas = [
        "SYN", "XMAS", "NULL", "FIN", "reset", "denial", "brute", "overflow",
        "scan", "bad checksum", "injection", "malformed", "conficker", "backdoor",
        "exploit", "dns-amplification", "monlist", "snmp", "ntp", "telnet"
    ]

    # Inicialização da tabela
    def criar_tabela():
        tabela = Table(title="Monitoramento de Rede - Possíveis Ameaças", box=box.SIMPLE_HEAD)
        tabela.add_column("PROTOCOLOS", style="cyan", no_wrap=True)
        tabela.add_column("IP Origem", style="red")
        tabela.add_column("IP Destino", style="green")
        tabela.add_column("Porta Src", justify="center")
        tabela.add_column("Porta Dst", justify="center")
        tabela.add_column("Alerta", style="bold yellow")
        return tabela

    tabela = criar_tabela()
    linha_contador = 0

    process = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, text=True)

    with Live(tabela, refresh_per_second=4, screen=True) as live:
        try:
            for linha in process.stdout:
                campos = linha.strip().split("\t")
                if len(campos) < 6:
                    continue

                proto, ip_origem, ip_destino, porta_origem, porta_destino, info = campos
                alerta = ""

                for palavra in palavras_suspeitas:
                    if palavra.lower() in info.lower():
                        alerta = f"Possível {palavra.upper()}"
                        break

                if alerta:
                    tabela.add_row(proto, ip_origem, ip_destino, porta_origem or "-", porta_destino or "-", alerta)
                    escrever_log(f"{proto} {ip_origem}:{porta_origem} -> {ip_destino}:{porta_destino} | {alerta}")
                    linha_contador += 1

                    if linha_contador >= 60:
                        tabela = criar_tabela()
                        live.update(tabela)
                        linha_contador = 0

        except KeyboardInterrupt:
            process.terminate()
            console.print("[bold red]Monitoramento interrompido.[/bold red]")

if __name__ == "__main__":
    monitorar_rede(interface="wlp0s20f3")  # Altere para sua interface de rede, se necessário