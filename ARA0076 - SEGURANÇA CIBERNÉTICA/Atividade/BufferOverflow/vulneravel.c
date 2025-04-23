#include <stdio.h>
#include <string.h>

void shell() {
    printf("Acesso root simulado concedido!\n");
    system("/bin/sh");
}

void vulneravel() {
    char buffer[64];
    printf("Digite algo: ");
    gets(buffer); // FUNÇÃO INSEGURA: permite Buffer Overflow
    printf("Você digitou: %s\n", buffer);
}

int main() {
    vulneravel();
    return 0;
}