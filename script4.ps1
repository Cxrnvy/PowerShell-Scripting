# TERCER SCRIPT: SISTEMA DE LOGs DE EVENTOS DEL SISTEMA
###############NOMBRE Y APELLIDO DEL AUTOR(A): Ariel Guerrero ####################

# Definimos la función para crear carpetas si no existen
function New-FolderCreation {
    # Habilita características avanzadas de funciones (como parámetros comunes)
    [CmdletBinding()]
    param(
        # Define un parámetro obligatorio que recibe el nombre de la carpeta
        [Parameter(Mandatory = $true)]
        [string]$foldername
    )

    # Crea la ruta absoluta uniendo la ubicación actual (Get-Location) con el nombre de la carpeta
    $logpath = Join-Path -Path (Get-Location).Path -ChildPath $foldername
    
    # Verificamos si la ruta NO existe (-not Test-Path)
    if (-not (Test-Path -Path $logpath)) {
        # Si no existe, crea el directorio (ItemType Directory) forzando su creación
        New-Item -Path $logpath -ItemType Directory -Force | Out-Null
    }

    # Devuelve la ruta completa de la carpeta creada o existente
    return $logpath
}

# Definimos la función principal para gestionar los Logs (Crear archivo y Escribir mensaje)
function Write-Log {
    # CmdletBinding permite usar parámetros avanzados y sets de parámetros
    [CmdletBinding()]
    param(
        # --- PARÁMETROS PARA EL MODO 'CREATE' (Crear archivo) ---
        
        # Recibe el nombre o lista de nombres para los archivos de log
        [Parameter(Mandatory = $true, ParameterSetName = 'Create')]
        [Alias('Names')]
        [object]$Name,                  

        # Extension del archivo (ej. 'log', 'txt')
        [Parameter(Mandatory = $true, ParameterSetName = 'Create')]
        [string]$Ext,

        # Nombre de la carpeta donde se guardarán
        [Parameter(Mandatory = $true, ParameterSetName = 'Create')]
        [string]$folder,

        # Switch para activar el modo de creación
        [Parameter(ParameterSetName = 'Create', Position = 0)]
        [switch]$Create,

        # --- PARÁMETROS PARA EL MODO 'MESSAGE' (Escribir dentro del archivo) ---
        
        # El mensaje que queremos guardar
        [Parameter(Mandatory = $true, ParameterSetName = 'Message')]
        [string]$message,

        # La ruta del archivo donde vamos a escribir
        [Parameter(Mandatory = $true, ParameterSetName = 'Message')]
        [string]$path,

        # Severidad del mensaje: Solo permite 'Information', 'Warning' o 'Error'
        [Parameter(Mandatory = $false, ParameterSetName = 'Message')]
        [ValidateSet('Information','Warning','Error')]
        [string]$Severity = 'Information',

        # Switch para activar el modo de escritura de mensaje
        [Parameter(ParameterSetName = 'Message', Position = 0)]
        [switch]$MSG
    )

    # Evaluamos qué set de parámetros usó el usuario (Create o Message)
    switch ($PsCmdlet.ParameterSetName) {
        
        # CASO 1: MODO CREAR ARCHIVO
        "Create" {
            $created = @() # Array para guardar las rutas de archivos creados

            # Aseguramos que $Name sea tratado siempre como un Array (lista), incluso si es un solo nombre
            $namesArray = @()
            if ($null -ne $Name) {
                if ($Name -is [System.Array]) { $namesArray = $Name }
                else { $namesArray = @($Name) }
            }

            # Obtenemos la fecha y hora actual para ponerla en el nombre del archivo
            $date1 = (Get-Date -Format "yyyy-MM-dd")
            $time  = (Get-Date -Format "HH-mm-ss")

            # Llamamos a la función auxiliar para crear la carpeta de logs
            $folderPath = New-FolderCreation -foldername $folder

            # Recorremos cada nombre que el usuario haya enviado
            foreach ($n in $namesArray) {
                
                $baseName = [string]$n

                # Construimos el nombre del archivo: Nombre_Fecha_Hora.Extension
                $fileName = "${baseName}_${date1}_${time}.$Ext"

                # Unimos la ruta de la carpeta con el nombre del archivo
                $fullPath = Join-Path -Path $folderPath -ChildPath $fileName

                # Intentamos crear el archivo (Try/Catch captura errores)
                try {
                    # Crea el archivo vacío
                    New-Item -Path $fullPath -ItemType File -Force -ErrorAction Stop | Out-Null
                    
                    # Agrega la ruta creada a la lista de resultados
                    $created += $fullPath
                }
                catch {
                    # Si falla, muestra una advertencia en consola
                    Write-Warning "Fallo al crear el archivo '$fullPath' - $_"
                }
            }

            # Devuelve la lista de rutas creadas
            return $created
        }

        # CASO 2: MODO ESCRIBIR MENSAJE
        "Message" {
            # Obtiene el directorio padre del archivo log
            $parent = Split-Path -Path $path -Parent
            
            # Si el directorio no existe, lo crea
            if ($parent -and -not (Test-Path -Path $parent)) {
                New-Item -Path $parent -ItemType Directory -Force | Out-Null
            }

            # Prepara el formato del mensaje: |Fecha| |Mensaje| |Severidad|
            $date = Get-Date
            $concatmessage = "|$date| |$message| |$Severity|"

            # Muestra el mensaje en la consola con colores según la severidad
            switch ($Severity) {
                "Information" { Write-Host $concatmessage -ForegroundColor Green } # Verde
                "Warning"     { Write-Host $concatmessage -ForegroundColor Yellow }# Amarillo
                "Error"       { Write-Host $concatmessage -ForegroundColor Red }   # Rojo
            }
            
            # Escribe el mensaje dentro del archivo de texto (Add-Content)
            Add-Content -Path $path -Value $concatmessage -Force

            # Devuelve la ruta donde se escribió
            return $path
        }

        default {
            # Si no se reconoce el set de parámetros, lanza un error
            throw "Unknown parameter set: $($PsCmdlet.ParameterSetName)"
        }
    }
}

# --- PRUEBA DE EJECUCIÓN (Líneas para demostrar el funcionamiento al profesor) ---

# Paso 1: Ejecuta la función en modo 'Create' para generar un archivo .log en la carpeta 'logs'
$logPaths = Write-Log -Name "Name-Log" -folder "logs" -Ext "log" -Create
Write-Host "Archivo de log creado exitosamente en: $logPaths"

# Paso 2: Si el archivo se creó, escribe un mensaje de prueba dentro de él (Modo 'Message')
if ($logPaths) {
    Write-Log -Message "Prueba de funcionamiento exitosa: El script está corriendo correctamente." -path $logPaths[0] -Severity Information -MSG
}