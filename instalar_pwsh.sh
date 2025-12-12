#Cesar Arciniegas
#Actualizar el índice de paquetes
sudo apt-get update

#Instalar dependencias necesarias
sudo apt-get install -y wget apt-transport-https software-properties-common

#Obtener la versión de la distribución para descargar el paquete correcto
source /etc/os-release

#Descargar el paquete de configuración de repositorios de Microsoft
wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb

#Instalar el paquete de Microsoft
sudo dpkg -i packages-microsoft-prod.deb

#Eliminar el archivo temporal
rm packages-microsoft-prod.deb

#Actualiza la powershell
sudo apt-get update

#Instala la powershell
sudo apt-get install -y powershell

#Comando para entrar a la consola
pwsh


#La instalación se puede hacer de 2 maneras
#1. Ejecutando linea por linea de codigo dentro de la terminal
#lo cual resulta positivo para un análisis mas detallado en ejecución y errores.
#2. Usar el comando "bash", ya que es mucho mas rápido y evita los errores humanos.
###Recomendable usar el paso número 2, debido a que resulta en un proceso mas corto
#y acelerado, evitando asi errores durante la instalación de la PowerShell