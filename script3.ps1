#Tercer script: Interfaz grafica 
Add-Type -AssemblyName System.Windows.Forms #Mediante Add-Type nos ayuda a cargar la libreria de Windows y esta sentencia nos ayuda a crear interfaces graficas
Add-Type -AssemblyName System.Drawing #Esta libreria su funcion es para manejar graficos como tamaños, colores y posiciones

$form = New-Object System.Windows.Forms.Form #Esta funcion es crear la ventana principal del formulario
$form.Text = "Input Form" #El titulo de la ventana 
$form.Size = New-Object System.Drawing.Size(500,250) #Tamaño de la ventana 
$form.StartPosition = "CenterScreen" #La posicion de la ventana en la pantalla

$textLabel1 = New-Object System.Windows.Forms.Label #Mediante esta asigancion creamos la primera etiqueta para identificar el primer campo
$textLabel1.Text = "Input 1:" #Aca mostramos el texto que mostrara la etiqueta
$textLabel1.Left = 20 #Posición x que es la distancia desde el borde izquierdo de la ventana
$textLabel1.Top = 20 # Posición y  que es la distancia desde el borde superior
$textLabel1.Width = 120 #Esta asignacion es el ancho de pixeles 

$textLabel2 = New-Object System.Windows.Forms.Label  #Mediante esta asigancion creamos la segunda etiqueta para identificar el segundo campo
$textLabel2.Text = "Input 2:"  #Aca mostramos el texto que mostrara la etiqueta
$textLabel2.Left = 20 #Posición x que es la distancia desde el borde izquierdo de la ventana
$textLabel2.Top = 60 #Posición y  que es la distancia desde el borde superior
$textLabel2.Width = 120 #Esta asignacion es el ancho de pixeles 

$textLabel3 = New-Object System.Windows.Forms.Label #Mediante esta asigancion creamos la tercera etiqueta para identificar el tercer campo
$textLabel3.Text = "Input 3:" #Aca mostramos el texto que mostrara la etiqueta
$textLabel3.Left = 20 #Posición x que es la distancia desde el borde izquierdo de la ventana
$textLabel3.Top = 100 #Posición y  que es la distancia desde el borde superior
$textLabel3.Width = 120 #Esta asignacion es el ancho de pixeles 

$textBox1 = New-Object System.Windows.Forms.TextBox #TextBox para que el usuario escriba el dato 1
$textBox1.Left = 150 #Esta asignacion es para colocar a la derecha que cada etiqueta
$textBox1.Top = 20
$textBox1.Width = 200  #Ancho del cuadro de texto

$textBox2 = New-Object System.Windows.Forms.TextBox #TextBox para que el usuario escriba el dato 2
$textBox2.Left = 150 #Esta asignacion es para colocar a la derecha que cada etiqueta
$textBox2.Top = 60
$textBox2.Width = 200 #Ancho del cuadro de texto

$textBox3 = New-Object System.Windows.Forms.TextBox #TextBox para que el usuario escriba el dato 3
$textBox3.Left = 150  #Esta asignacion es para colocar a la derecha que cada etiqueta
$textBox3.Top = 100
$textBox3.Width = 200 #Ancho del cuadro de texto
 
$defaultValue = "" #Valor por defecto para los cuadros de texto
$textBox1.Text = $defaultValue
$textBox2.Text = $defaultValue
$textBox3.Text = $defaultValue

$button = New-Object System.Windows.Forms.Button #Creamos el boton de "OK"
$button.Left = 360
$button.Top = 140
$button.Width = 100
$button.Text = "OK"

$button.Add_Click({ #Acción que ocurre cuando se presiona el botón OK
    $form.Tag = @{ #Guardamos los valores escritos en la ventana en la propiedad Tag del formulario
        Box1 = $textBox1.Text
        Box2 = $textBox2.Text
        Box3 = $textBox3.Text
    }
    $form.Close()  #Cierra la ventana
})
#Para agregar todos los elementos al formulario
$form.Controls.Add($button)
$form.Controls.Add($textLabel1)
$form.Controls.Add($textLabel2)
$form.Controls.Add($textLabel3)
$form.Controls.Add($textBox1)
$form.Controls.Add($textBox2)
$form.Controls.Add($textBox3)
#Mostrar la ventana
$form.ShowDialog() | Out-Null
#Devolver los valores escritos por el usuario
return $form.Tag.Box1, $form.Tag.Box2, $form.Tag.Box3
