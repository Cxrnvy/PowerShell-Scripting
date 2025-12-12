#Cesar Arciniegas
#Actualizar el índice de paquetes
#Se actualiza el índice local de los paquetes para que el sistema disponga 
#de las últimas versiones existentes antes de la instalación de nada.
sudo apt-get update

#Instalar dependencias necesarias
#Se instalan las herramientas necesarias:
#wget: Para la descarga de archivos desde Internet a través de la línea de comandos.
#apt-transport-https: Para que pueda descargar elementos seguros vía HTTPS.
#software-properties-common: Para gestionar repositorios de software independientes.
sudo apt-get install -y wget apt-transport-https software-properties-common

#Obtener la versión de la distribución para descargar el paquete correcto
#El comando 'source' lee el archivo /etc/os-release para cargar variables del sistema.
#Esto es CRÍTICO para obtener la variable $VERSION_ID (ej. 20.04 o 22.04)
#y poder descargar el paquete compatible exacto para esta máquina.
source /etc/os-release

#Descargar el paquete de configuración de repositorios de Microsoft
#Se utiliza wget para bajar el archivo .deb oficial de Microsoft.
#Se inyecta la variable $VERSION_ID para asegurar la compatibilidad con la versión de Ubuntu.
wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb

#Instalar el paquete de Microsoft
#Se utiliza dpkg (Debian Package) para instalar el paquete descargado.
#Esto no instala PowerShell aún, sino que añade a Microsoft como "fuente confiable"
#en nuestro sistema para poder buscar sus programas.
sudo dpkg -i packages-microsoft-prod.deb

#Eliminar el archivo temporal
#Se elimina el archivo instalador .deb descargado porque ya fue procesado y no ocupamos espacio innecesario.
rm packages-microsoft-prod.deb

#Actualiza la powershell
#Actualizamos la lista otra vez para que aparezcan los programas de Microsoft recién agregados.
sudo apt-get update

#Instala la powershell
sudo apt-get install -y powershell

#Comando para entrar a la consola de PowerShell
pwsh


#La instalación se puede hacer de 2 maneras
#1. Ejecutando linea por linea de codigo dentro de la terminal
#lo cual resulta positivo para un análisis mas detallado en ejecución y errores.
#2. Usar el comando "bash", ya que es mucho mas rápido y evita los errores humanos.
###Recomendable usar el paso número 2, debido a que resulta en un proceso mas corto
#y acelerado, evitando asi errores durante la instalación de la PowerShell
