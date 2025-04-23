# 🛡️ Sistema de Comando e Controle (C2) com SSL/TLS

Este projeto implementa um sistema de Comando e Controle (C2) em Python, permitindo a comunicação segura entre um servidor e múltiplos agentes (clientes). Utiliza autenticação mútua e criptografia SSL/TLS para garantir a integridade e confidencialidade das informações transmitidas.

---

## 📋 Índice

- [🛡️ Sistema de Comando e Controle (C2) com SSL/TLS](#️-sistema-de-comando-e-controle-c2-com-ssltls)
  - [📋 Índice](#-índice)
  - [📖 Descrição](#-descrição)
  - [⚙️ Funcionalidades](#️-funcionalidades)
  - [🧰 Pré-requisitos](#-pré-requisitos)
  - [🛠️ Instalação](#️-instalação)
  - [🔐 Geração de Certificados](#-geração-de-certificados)
  - [🚀 Execução](#-execução)
    - [Servidor](#servidor)
    - [Agente](#agente)
  - [📁 Estrutura de Diretórios](#-estrutura-de-diretórios)
  - [🧪 Tecnologias Utilizadas](#-tecnologias-utilizadas)
  - [🤝 Contribuições](#-contribuições)
  - [📄 Licença](#-licença)

---

## 📖 Descrição

O sistema C2 permite que um servidor envie comandos para múltiplos agentes conectados, que por sua vez executam os comandos e retornam os resultados. A comunicação é protegida por SSL/TLS com autenticação mútua, garantindo que apenas agentes autorizados possam se conectar ao servidor.

---

## ⚙️ Funcionalidades

- Comunicação segura entre servidor e agentes usando SSL/TLS.
- Autenticação mútua com certificados digitais.
- Execução de comandos remotos nos agentes.
- Suporte a múltiplos agentes simultaneamente.
- Geração automatizada de certificados com script em Bash.

---

## 🧰 Pré-requisitos

- Python 3.6 ou superior.
- OpenSSL instalado no sistema.
- Sistema operacional baseado em Unix/Linux.

---

## 🛠️ Instalação

1. Clone o repositório:

     ```bash
     git clone https://github.com/aXR6/Facimp_repo_2025.1
=     ```

2. Instale as dependências necessárias (se houver).

---

## 🔐 Geração de Certificados

Utilize o script `gerar_certificados.sh` para gerar os certificados necessários para o servidor e os agentes:

```bash
chmod +x ger_cert
./ger_cert
```

Este script criará os seguintes diretórios e arquivos:

- `ca/`: Contém a Autoridade Certificadora (CA).
- `servidor/`: Contém os certificados e chaves do servidor.
- `cliente/`: Contém os certificados e chaves dos agentes.

---

## 🚀 Execução

### Servidor

No diretório `servidor/`, execute:

```bash
python3 Servidor.py
```

### Agente

No diretório `cliente/`, execute:

```bash
python3 agente.py
```

Certifique-se de que o servidor esteja em execução antes de iniciar os agentes.

---

## 📁 Estrutura de Diretórios

```plaintext
nome-do-repositorio/
├── ca/
│   ├── ca.crt
│   └── ca.key
├── cliente/
│   ├── agente.py
│   ├── client.crt
│   ├── client.key
│   └── client.csr
├── servidor/
│   ├── Servidor.py
│   ├── server.crt
│   ├── server.key
│   └── server.csr
├── gerar_certificados.sh
└── README.md
```

---

## 🧪 Tecnologias Utilizadas

- Python 3.6+
- OpenSSL
- Sockets
- SSL/TLS

---

## 🤝 Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou enviar pull requests.

---

## 📄 Licença

Este projeto está licenciado sob a [MIT License](LICENSE).
