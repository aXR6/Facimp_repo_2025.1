#!/bin/bash

set -e

echo "Atualizando os repositórios..."
sudo apt update

echo "Instalando ferramentas disponíveis nos repositórios oficiais..."
sudo apt install -y aircrack-ng nmap wireshark reaver ruby-full build-essential libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev zlib1g-dev sudo

echo "Instalando o WPScan via RubyGems..."
sudo gem install wpscan

echo "Todas as ferramentas foram instaladas com sucesso!"
