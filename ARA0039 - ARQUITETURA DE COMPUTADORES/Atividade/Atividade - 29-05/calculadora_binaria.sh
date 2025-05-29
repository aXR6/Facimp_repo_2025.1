#!/bin/bash

# Função para exibir o menu principal
menu_principal() {
    echo "==============================="
    echo "   Calculadora Binária Interativa"
    echo "==============================="
    echo "1. Converter Binário para Decimal"
    echo "2. Converter Decimal para Binário"
    echo "3. Converter Binário para Hexadecimal"
    echo "4. Converter Binário para Octal"
    echo "5. Operações Aritméticas com Binários"
    echo "6. Converter Texto para Binário"
    echo "7. Converter Binário para Texto"
    echo "8. Sair"
    echo "==============================="
    read -p "Escolha uma opção: " opcao
}

# Função para converter binário para decimal
binario_para_decimal() {
    read -p "Digite um número binário: " bin
    if [[ "$bin" =~ ^[01]+$ ]]; then
        decimal=$((2#$bin))
        echo "Decimal: $decimal"
    else
        echo "Entrada inválida. Certifique-se de digitar apenas 0s e 1s."
    fi
}

# Função para converter decimal para binário
decimal_para_binario() {
    read -p "Digite um número decimal: " dec
    if [[ "$dec" =~ ^[0-9]+$ ]]; then
        bin=$(echo "obase=2; $dec" | bc)
        echo "Binário: $bin"
    else
        echo "Entrada inválida. Digite apenas números inteiros positivos."
    fi
}

# Função para converter binário para hexadecimal
binario_para_hexadecimal() {
    read -p "Digite um número binário: " bin
    if [[ "$bin" =~ ^[01]+$ ]]; then
        dec=$((2#$bin))
        hex=$(printf '%X\n' "$dec")
        echo "Hexadecimal: $hex"
    else
        echo "Entrada inválida. Certifique-se de digitar apenas 0s e 1s."
    fi
}

# Função para converter binário para octal
binario_para_octal() {
    read -p "Digite um número binário: " bin
    if [[ "$bin" =~ ^[01]+$ ]]; then
        dec=$((2#$bin))
        oct=$(printf '%o\n' "$dec")
        echo "Octal: $oct"
    else
        echo "Entrada inválida. Certifique-se de digitar apenas 0s e 1s."
    fi
}

# Função para realizar operações aritméticas com binários
operacoes_aritmeticas() {
    read -p "Digite o primeiro número binário: " bin1
    read -p "Digite o segundo número binário: " bin2
    if [[ "$bin1" =~ ^[01]+$ && "$bin2" =~ ^[01]+$ ]]; then
        dec1=$((2#$bin1))
        dec2=$((2#$bin2))
        soma=$((dec1 + dec2))
        subtracao=$((dec1 - dec2))
        multiplicacao=$((dec1 * dec2))
        if [ "$dec2" -ne 0 ]; then
            divisao=$((dec1 / dec2))
            resto=$((dec1 % dec2))
        else
            divisao="Indefinida (divisão por zero)"
            resto="Indefinido (divisão por zero)"
        fi
        echo "Resultados:"
        echo "Soma: $soma (Decimal) / $(echo "obase=2; $soma" | bc) (Binário)"
        echo "Subtração: $subtracao (Decimal) / $(echo "obase=2; $subtracao" | bc) (Binário)"
        echo "Multiplicação: $multiplicacao (Decimal) / $(echo "obase=2; $multiplicacao" | bc) (Binário)"
        echo "Divisão: $divisao"
        echo "Resto: $resto"
    else
        echo "Entradas inválidas. Certifique-se de digitar apenas 0s e 1s."
    fi
}

# Função para converter texto para binário
texto_para_binario() {
    read -p "Digite o texto: " texto
    echo -n "Binário: "
    for (( i=0; i<${#texto}; i++ )); do
        printf "%08d " "$(echo "obase=2; $(printf '%d' "'${texto:$i:1}")" | bc)"
    done
    echo ""
}

# Função para converter binário para texto
binario_para_texto() {
    read -p "Digite o binário (separe os bytes com espaços): " binario
    for byte in $binario; do
        printf "\\$(echo "obase=8; ibase=2; $byte" | bc)"
    done
    echo ""
}

# Loop principal
while true; do
    menu_principal
    case $opcao in
        1) binario_para_decimal ;;
        2) decimal_para_binario ;;
        3) binario_para_hexadecimal ;;
        4) binario_para_octal ;;
        5) operacoes_aritmeticas ;;
        6) texto_para_binario ;;
        7) binario_para_texto ;;
        8) echo "Saindo..."; break ;;
        *) echo "Opção inválida. Tente novamente." ;;
    esac
    echo ""
done
