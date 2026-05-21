
### .SYNOPSIS
  Es una Clase que implementa documentos logs.

### .DESCRIPTION
  Consta de una Clase que contiene funciones para crear, editar, destruir
  documentos Log de forma sencilla. 

### .PARAMETER [-path] <string> [-name] <string>
  Descripción de qué valor espera este parámetro y para qué sirve.

### .EXAMPLE 

    new() aquí se crea un objeto de la clase Log con los parametros, con nombre y path ajustados
    -path = "$PSScriptRoot\Log\"
    -name = "Log_323.txt"
    $log = [Log]::new("$PSScriptRoot\Log\","Log_323.txt")
    

    .create() esta función crea un log con un mensaje de inicio
    PARAMETRO:
        -header <string>  texto de inicio del log, poscicionado en la parte superior de este
    EJEMPLO:
    $mensaje_inicio = "Inicia Log aplicación ::..."
    $Log.create($mensaje_inicio)


    .insert() esta función inserta una línea de texto en el documento log
    PARAMETRO: 
        -text <string>  Es el texto que insertará en el documento
    EJEMPLO:
    $lntext = "Insercion en base de datos con fecha xx/xx/xxxx"
    $log.insert($lntext)


    .line() esta función crea un linea para separa información en el log
    PARAMETROS:
        -length <int> determina cunatos caracteres forman la línea
        -chrSep <string> es el carater que formará la linea de separación
    
    EJEMPLO:
    $log.line(10, "*")


    .jump() crea un salto de linea dentrop del docuemnto log
    PARAMETROS:
    EJEMPLO:
    $log.jump()

    .cartel() Encierra un texto dentro de una serie de caracteres determinados por el usuario
              en forma de cartel, para destacar información importante
    EJEMPLO DE RESULTADO:
        ==========
        =        =
        =  Hola  =
        =        =
        ==========
    PARAMETROS:
    
    -text <string> Es el texto a encerrar
    -charRound Es el carater elegido para formar el cartel
    -padding separacion del texto de la paredes izquierda y derecha

    PRECAUCIÓN: Esta función no adminte acentuaciones, carateres especiales y solo admite como salto de línea
                el caracter usado en powershell [`n]
    
    EJEMPLO:
    $log.cartel("Creacion de log  de prueba`nUsuario : 15984 ", "*", 2)

### .NOTES
  esta version es un prototipo. no usar en proyectos profesionales sin aplicar mejoras

### .LINK
  
#>