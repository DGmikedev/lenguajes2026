
<#
.SYNOPSIS
  Es una Clase que implementa documentos logs.

.DESCRIPTION
  Consta de una Clase que contiene funciones para crear, editar, destruir
  documentos Log de forma sencilla. 

.PARAMETER [-path] <string> [-name] <string>
  Descripción de qué valor espera este parámetro y para qué sirve.

.EXAMPLE 

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

.NOTES
  esta version es un prototipo. no usar en proyectos profesionales sin aplicar mejoras

.LINK
  https://github.com/DGmikedev
#>
class Log
{
    [string]$path
    [string]$name
    [string]$logpath

    Log( [string]$_path, [string]$_name ){
        $this.path   = $_path
        $this.name = $_name
        $this.logpath = Join-Path $this.path $this.name
    }

    [void] create([string]$header){
        
        try{

            New-Item -Path $this.path -ItemType "File" -Name $this.name -Value $header  -Force 

        }catch{

            Write-Warning " !!Error!! al crear el docuemnto log: [ $($_.Exception.Message)] "

            Exit 1
        }
         
    }   

    [string] cartel($text, $charRound, $padding){

        $charSpc = ""
        $horizontalBar = ""
        $spcIzq = ""
        $sepIzq = 0

        # Saprar mensaje por renglones
        $arrayMensajes = [system.Collections.ArrayList]@()
        $arrayMensajes = $text -split "`n"

        $maximo = 0

        # Se obtine la longitud del renglon más largo
        for( $i = 0; $i -lt $arrayMensajes.Count; $i++  ){

            if( $maximo -lt $arrayMensajes[$i].Length ){ 

                $maximo =   $arrayMensajes[$i].Length

            }else{

                $maximo = $maximo

            }  

        }

        # Se crean los trabezaños superior e inferior 
        # llamada Barra Horizontal

        $fillHorizontal = ( 2 * $padding ) + 2

        for( $j = 0; $j -lt ($maximo + $fillHorizontal) + 1; $j++ ){

            $horizontalBar += $charRound

        }

        # Llena con espacios la separación entre el texto y los postes anterior y posterior
        for( $k = 0; $k -lt $padding; $k++ ){

            $charSpc += " "

        }

        # Adicionando los espacios de separación a cada renglon del mensaje
        for( $l = 0; $l -lt $arrayMensajes.Length; $l++ ){
            
            $sepIzq = ( $maximo + $fillHorizontal ) - ( $charRound.Length +  $charSpc.Length +  $arrayMensajes[$l].Length )

            for( $m = 0; $m -lt ($sepIzq - 1); $m++ ){
                $spcIzq += " "
            }

            $arrayMensajes[$l] = "$charRound $charSpc"+$arrayMensajes[$l]+"$spcIzq$charRound`n"
            $spcIzq = ""
        }

        $arrayToString = $horizontalBar + "`n"

        # Calcula el largo de la horizontal bar y 
        # solo cololca el primer y último caracter
        # dejando un espacio entre ellos
        
        $hrzBarSpcLng = $horizontalBar.Length

        $hrzBarSpc = ""

        for( $h = 0; $h -le $hrzBarSpcLng; $h++ ){

            if( $h -eq 0 -or $h -eq $hrzBarSpcLng - 1 ){

                $hrzBarSpc += $charRound

            }else{

                $hrzBarSpc += " "
                
            }
            
        }
        
        #########################################

        # Se concatena todo lo calculado
        # Para juntar, Barrra horizonta, Barra horizontal con espacio
        # entre ellos 

        $arrayToString += "$hrzBarSpc`n"

        for( $e = 0; $e -lt $arrayMensajes.Count; $e++ ){

            $arrayToString += $arrayMensajes[$e]

        }

        $arrayToString += "$hrzBarSpc`n"

        $arrayToString += "$horizontalBar`n"

        return $arrayToString
    }
    
    [void] insert([string]$text){

        try{

            Add-Content -Value $text -Path $this.logpath

        }catch{

            Write-Warning "Error al insertar en el docuemnto log: [ $($_.Exception.Message)]"

            Exit 1

        }
        
    }  

    [void] jump(){

        try{

            Add-Content -Value "" -Path $this.logpath

        }catch{

            Write-Warning "Error al saltar renglon en el docuemnto log: [ $($_.Exception.Message)]"

            Exit 1
            

        }
    } 

    [void] line([int]$length, [string]$chrSep){

        $sp = ""

        for($i=0; $i -lt $length; $i++){

            $sp +=  $chrSep

        }

        try{

            Add-Content -Value $sp -Path $this.logpath

        }catch{

            Write-Warning "Error al crear una linea en el docuemnto log: [ $($_.Exception.Message)]"

            Exit 1

        }
    }

}

