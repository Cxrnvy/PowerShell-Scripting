# SEGUNDO SCRIPT: CREAR BARRA DE PROGRESO
############### NOMBRE Y APELLIDO DE LA AUTORA: DANNA SIMALUISA ####################
function Start-ProgressBar { # Con la palabra fuction definimos una funcion que en este caso se llama Start-ProgressBar
    [CmdletBinding()] # Esta etiqueta convierte la funcion basica en una mas avanzada haciendo que se comporte como los comandos nativos del sistema
    param ( # Con esto establecemos parametros para que la funcion pueda correr 
        [Parameter(Mandatory = $true)] # En este parametro establecemos que es obligatorio con Mandatory
        $Title, # Creamos la variable Title con $ que guardara el titulo que va a aparecer arriba de la barra
        
        [Parameter(Mandatory = $true)] # Este segundo parametro esta establecido tb como obligatorio
        [int]$Timer # Establecemos con [int] que esta variable es un entero y se va a llamar Timer con la cual controlaremos el tiempo
    )
    
    for ($i = 1; $i -le $Timer; $i++) { # Con este bucle for establecemos un contador que empieza en uno ($i = 1) y siempre y cuando nuestra variable i sea menor que Timer ($i -le $Timer) vamos a sumar uno ($i++)
        Start-Sleep -Seconds 1 # Para que la barra se llene al ritmo de un reloj real se pausa el script (Start-Sleep) por un segundo (-Seconds 1)
        $percentComplete = ($i / $Timer) * 100 # En la variable llamada percentComplete guardamos el porcentaje que va teniendo nuestra barra de progreso $i es la parte que ya se esta completando y $Timer es el total por lo cual lo dividimos y multiplicamos por 100 para obtener el porcentaje
        Write-Progress -Activity $Title -Status "$i seconds elapsed" -PercentComplete $percentComplete # Aca dibujamos la barra de progreso con Write-Progress con -Activity mostramos el titlo ($Title) y con -Status mostramos el progreso que va teniendo ($i) y para finalizar con -PercentComplete hacemos que la barra funcione en base a lo que establecimos en la variable $percentComplete
    }
} 
Start-ProgressBar -Title "Test timeout" -Timer 30 # Aca hacemos un llamado a la funcion que creamos al inicio, estableciendo que Title sera Test timeout y que el tiempo (-Timer) seran 30 segundos que es lo que va a durar la barra