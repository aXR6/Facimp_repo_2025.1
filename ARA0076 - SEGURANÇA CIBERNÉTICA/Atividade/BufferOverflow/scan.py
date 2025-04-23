import nmap

def scan_target(ip):
    nm = nmap.PortScanner()
    nm.scan(ip, arguments='-sV')
    for host in nm.all_hosts():
        print(f"Host: {host}")
        for proto in nm[host].all_protocols():
            lport = nm[host][proto].keys()
            for port in lport:
                service = nm[host][proto][port]['name']
                version = nm[host][proto][port]['version']
                print(f"Port: {port}\tService: {service}\tVersion: {version}")
                # Aqui você pode adicionar lógica para identificar versões conhecidas por vulnerabilidades de Buffer Overflow

if __name__ == "__main__":
    target_ip = input("Digite o IP do alvo: ")
    scan_target(target_ip)