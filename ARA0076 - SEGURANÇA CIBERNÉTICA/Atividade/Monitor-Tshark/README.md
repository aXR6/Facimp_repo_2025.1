# 📡 Monitoramento de Rede com TShark e Python

Este projeto é um script em Python 3 que utiliza o TShark para monitorar o tráfego de rede em tempo real, identificando possíveis ameaças, vulnerabilidades e comportamentos suspeitos. O script destaca os endereços IP de origem e destino, proporcionando uma visão clara das atividades na rede.

---

## 🚀 Funcionalidades

- Monitoramento em tempo real do tráfego de rede utilizando TShark.
- Identificação de possíveis ameaças, como pacotes com flags SYN e FIN suspeitos.
- Exibição organizada das informações em tabelas coloridas no terminal.
- Limitação da exibição a 60 linhas, com atualização contínua.
- Registro de logs diários em arquivos `.log` organizados por data.

---

## 🛠️ Requisitos

- Python 3.6 ou superior.
- TShark instalado e acessível no PATH do sistema.
- Sistema operacional Debian 12 ou compatível.

---

## 📦 Instalação

1. Clone este repositório:

    ```bash
    git clone https://github.com/aXR6/Estudo_DeepSeek_Ollma
    ```

2. Instale as dependências necessárias:

    ```bash
    pip install -r requirements.txt
    ```

3. Certifique-se de que o TShark está instalado:

    ```bash
    sudo apt-get -y install tshark
    ```

---

## ⚙️ Uso

Execute o script principal:

```bash
python3 mon-tshark.py
```

O script iniciará o monitoramento da interface de rede padrão, exibindo as informações no terminal e salvando os logs no diretório `logs/`.

---

## 📝 Exemplo de Saída

```plaintext
[2025-04-23 12:08:00] eth:ethertype:ip:tcp 192.7.0.42:58692 -> 89.58.44.75:443 | Possível FIN
[2025-04-23 12:08:00] eth:ethertype:ip:tcp 192.7.0.42:40824 -> 13.107.246.33:443 | Possível FIN
[2025-04-23 12:08:00] eth:ethertype:ip:tcp 17.106.240.58:443 -> 192.7.0.42:40824 | Possível FIN
...
```
---

## 🤝 Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou enviar pull requests.

---

## 📄 Licença

Este projeto está licenciado sob a Licença MIT. Consulte o arquivo `LICENSE` para obter mais informações.