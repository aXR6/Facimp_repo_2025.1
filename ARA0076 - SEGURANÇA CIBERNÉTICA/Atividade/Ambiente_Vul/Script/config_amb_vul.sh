#!/bin/bash

######################################################################
#                                                                    #
# Você poderá baixar uma VM pronta para testes de segurança.         #
# Link: https://www.rapid7.com/products/metasploit/metasploitable/   #
#                                                                    #
######################################################################

# Script de Configuração do Ambiente Vulnerável

# Atualiza o sistema
apt-get update && apt-get upgrade -y

# Instala serviços vulneráveis

# 1. vsftpd 2.3.4 - FTP Vulnerável
apt-get install -y vsftpd=2.3.4-1ubuntu1

# 2. OpenSSH com configurações fracas
apt-get install -y openssh-server
sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart ssh

# 3. Telnetd - Serviço Telnet
apt-get install -y xinetd telnetd
echo "service telnet
{
    disable = no
    flags = REUSE
    socket_type = stream
    wait = no
    user = root
    server = /usr/sbin/in.telnetd
    log_on_failure += USERID
}" > /etc/xinetd.d/telnet
systemctl restart xinetd

# 4. Samba com configurações vulneráveis
apt-get install -y samba
echo "[vulnerable]
   path = /srv/samba/share
   writable = yes
   browsable = yes
   guest ok = yes
   guest only = yes
   create mask = 0777
   directory mask = 0777" >> /etc/samba/smb.conf
mkdir -p /srv/samba/share
chmod -R 0777 /srv/samba/share
systemctl restart smbd

# 5. Apache Tomcat 6 com credenciais padrão
apt-get install -y tomcat6
echo "<user username='admin' password='admin' roles='manager-gui,admin-gui'/>" >> /etc/tomcat6/tomcat-users.xml
systemctl restart tomcat6

# 6. Distcc - Serviço de compilação distribuída
apt-get install -y distcc
echo "allowednetworks: 127.0.0.1 192.168.0.0/24
listennetworks: 0.0.0.0
zeroconf: false" > /etc/distcc/hosts
systemctl restart distcc

# 7. IRC UnrealIRCd 3.2.8.1 com backdoor conhecido
wget http://www.example.com/unrealircd-3.2.8.1-backdoored.tar.gz
tar zxvf unrealircd-3.2.8.1-backdoored.tar.gz
cd unrealircd-3.2.8.1
./configure
make
make install