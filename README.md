Neste script, a variável network define a rede a ser varrida, e o comando nmap é utilizado para encontrar hosts Windows, identificar as portas abertas nos hosts, e identificar as vulnerabilidades no sistema operacional Windows.

Após isso, o arquivo de texto com as vulnerabilidades encontradas é analisado para selecionar as vulnerabilidades mais críticas, e o Metasploit é utilizado para verificar a disponibilidade dos exploits para essas vulnerabilidades e explorá-las nos hosts selecionados.

As informações da exploração são registradas em um arquivo de texto para referência futura.

sudo chmod +x winscan.sh
sudo ./winscan.sh
