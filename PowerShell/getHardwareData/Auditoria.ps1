# Este Script Obtiene la información de CPU y la manda imprimir en un formato determinado
# en el directorio repositorio para que los palicativos de auditoria puedan consulatrla

# Directory name, slash nescessary
$nameDir = "\RepositoryDocsPS"

 # Set date
$date = Get-Date -Format "MMddyyyy"

# Set date with format
$dateFD = Get-Date -Format "dd-MM-yyyy"

#$RetunExp = 0     <<< sospecha quitar

# acm to for
$Eject = 1

$msj = ""

$localpath     = (get-Location).Path

# A path upgrade
$localpathback = Split-Path $localpath -Parent

$Paths = @{
    EXPORT = "$localpathback\CommonFunctions\exportCstmObjctToJsn.psm1"
    CPU    = "$localpath\getDataCPUModule.psm1"
    RAM    = "$localpath\getDataRAMModule.psm1"
    DISC   = "$localpath\getDataDISKModule.psm1"
    EQPMET = "$localpath\getDataEQPModule.psm1"
    NET    = "$localpath\getDataNETModule.psm1"
    FDISK  = "$localpath\getDataFDISKModule.psm1"
    IPCNF  = "$localpath\getDataIPNTModule.psm1"
    UUID   = "$localpath\getDataUIDModule.psm1"
    TMZONE = "$localpathback\getTimeZone\getDataTimeZoneServer.psm1"
    DOCMK  = "$localpathback\CommonFunctions\toDocuments\New-Document.psm1"
    DIRMK  = "$localpathback\CommonFunctions\toDocuments\New-Directory.psm1"
    WRTDOC = "$localpathback\CommonFunctions\toDocuments\Write-Document.psm1"
}

foreach($fls in $paths.GetEnumerator()){
    
    $Clave = $fls.Key
    $Valor = $fls.Value


    if( Test-Path $fls.Value ){

        Write-Host "Comprobando existencia del modulo:  $valor OK" -ForegroundColor  Green

    }else{

        $Eject = 0
        Write-Host "Comprobando existencia del modulo:  $valor  ERROR" -ForegroundColor  Red
        $msj = "Error al Comprobar la ruta del archivo:  $Valor"


    }
}

if($Eject -eq 1){

    # Import of Common Functions
    Import-Module -Name "$localpathback\CommonFunctions\exportCstmObjctToJsn.psm1"
    # Module  Get Data CPU 
    Import-Module -Name "$localpath\getDataCPUModule.psm1"
    # Module Get Data RAM
    Import-Module -Name "$localpath\getDataRAMModule.psm1"
    # Module Get Data Disk
    Import-Module -Name "$localpath\getDataDISKModule.psm1"
    # Module Get Data Equipment
    Import-Module -Name "$localpath\getDataEQPModule.psm1"
    # Module Get Data MAC
    Import-Module -Name "$localpath\getDataNETModule.psm1"
    # Module Get Data Fisical Disk
    Import-Module -Name "$localpath\getDataFDISKModule.psm1"
    # Module Get Data IP Network
    Import-Module -Name "$localpath\getDataIPNTModule.psm1"
    # Module Get Data UUID
    Import-Module -Name "$localpath\getDataUIDModule.psm1"
    # Module Get Data TimeZone
    Import-Module -Name "$localpathback\getTimeZone\getDataTimeZoneServer.psm1"
    # Module Make Document
    Import-Module -Name "$localpathback\CommonFunctions\toDocuments\New-Document.psm1"
    # Module Make Directory
    Import-Module -Name "$localpathback\CommonFunctions\toDocuments\New-Directory.psm1"
    # Module Write Document
    Import-Module -Name "$localpathback\CommonFunctions\toDocuments\Write-Document.psm1"

   
    ############################### Repostories ############################################### 

    # Setting Repository of Docs
    $PathRepository = New-Directory -path $localpathback -nameDir $nameDir | ConvertFrom-JSON

    if($PathRepository.RESULTADO){

        Write-Host "Repositorio Creado en: " $PathRepository.PATH         -ForegroundColor Green

    }else{

        Write-Host "Hubo un error al crear el repositorio de documentos"  -ForegroundColor Red
        Exit 1
    }


    # Setting Log Repository

    $logRepo = New-Directory -path $PathRepository.PATH -nameDir "\log" | ConvertFrom-JSON
   
    if($logRepo.RESULTADO){

        Write-Host "Repositorio del log creado en: " $logRepo.PATH                   -ForegroundColor Green

    }else{

        Write-Host "Hubo un error al crear el repositorio del LOG:" $logrepo.PATH    -ForegroundColor Red
        Exit 1
    }

    ########################################################################################### 

    # Make Document of LOG

    $nameLog = "log_auditoria_hardware_$date.txt"

    $logDoc = New-Document -name $nameLog -path $logRepo.PATH -value "" | ConvertFrom-JSON

    if($logDoc.RESULTADO -eq 1){

        Write-Host "1Docuemnto LOG Creado: " $logDoc.PATH                             -ForegroundColor Green
    
    }elseif($logDoc.RESULTADO -eq 2){

        Write-Host "2Docuemnto LOG Ya fue creado: " $logDoc.PATH                      -ForegroundColor Cyan

    }else{

        Write-Host "3Hubo un error al crear el LOG" $logDoc.PATH                      -ForegroundColor Red
        Exit 1
    }

    ########################################################################################### 

    $lgPath = $logDoc.PATH 

    $txt = "=================================================================================="

    Add-Content -Path $lgPath  -Value $txt
    
    Add-Content -Path $lgPath  -Value "LOG DE AUDITORIA EN SERVIDOR, HARDWARE Y SOFTAWARE               |  $dateFD   |"
    Add-Content -Path $lgPath  -Value $txt

    # #Path of Respository with name
    $PathReportWName= Join-Path $PathRepository.PATH "\auditoria_hardware"

    Write-Host "Compilando la informacion"                                 -ForegroundColor Cyan

    Add-Content -Path $lgPath  -Value "" 
    Add-Content -Path $lgPath  -Value "COMNPILANDO E INSERTADO INFORMACION EN JSON" 
    Add-Content -Path $lgPath  -Value "" 

    # Creating an Object 
    # Including searching of errors inside body data
    $ObjectSend = [PSCustomObject]@{
        CPU    = if( "ERROR EN MODULO" -eq (Getcpu))      { 
                    Write-Host "ERROR EN MODULO CPU MAL:" $Paths.CPU     -ForegroundColor Red | Getcpu      
                }else{ 
                    (Getcpu)      
                    Add-Content -Path $lgPath  -Value "DATA CPU INSERTADO CON EXITO"
            } 
        RAM    = if( "ERROR EN MODULO" -eq (Getram))      { 
                    Write-Host "ERROR EN MODULO RAM MAL"   $Paths.RAM    -ForegroundColor Red | Getram      
                }else{ 
                    (Getram)
                    Add-Content -Path $lgPath  -Value "DATA MEMORIA RAM INSERTADO CON EXITO"
            } 
        DISC   = if( "ERROR EN MODULO" -eq (Getdisk))     { 
                    Write-Host "ERROR EN MODULO DISC MAL"  $Paths.DISC   -ForegroundColor Red | Getdisk     
                }else{ 
                    (Getdisk)
                    Add-Content -Path $lgPath  -Value "DATA PARTICIONES INSERTADO CON EXITO"
            } 
        EQPMET = if( "ERROR EN MODULO" -eq (Geteqp))      { 
                    Write-Host "ERROR EN MODULO EQPMET MAL"$Paths.EQPMET -ForegroundColor Red | Geteqp      
                }else{ 
                    (Geteqp)
                    Add-Content -Path $lgPath  -Value "DATA EQUIPO FISICO INSERTADO CON EXITO"
            } 
        NET    = if( "ERROR EN MODULO" -eq (Getnetadp))   { 
                    Write-Host "ERROR EN MODULO NET MAL"   $Paths.NET    -ForegroundColor Red | Getnetadp   
                }else{ 
                    (Getnetadp)
                    Add-Content -Path $lgPath  -Value "DATA CONFIGURACION RED-NET INSERTADO CON EXITO"
                }

        FDISK  = if( "ERROR EN MODULO" -eq (Getfdisk))    { 
                    Write-Host "ERROR EN MODULO FDISK MAL" $Paths.FDISK  -ForegroundColor Red | Getfdisk    
                }else{ 
                    (Getfdisk)
                    Add-Content -Path $lgPath  -Value "DATA DISCO(S) FISICOS INSERTADO CON EXITO"    
            } 
        IPCNF  = if( "ERROR EN MODULO" -eq (Getipnet))    { 
                    Write-Host "ERROR EN MODULO IPCNF MAL" $Paths.IPCNF  -ForegroundColor Red | Getipnet    
                }else{ 
                    (Getipnet) 
                    Add-Content -Path $lgPath  -Value "DATA CONFIGURACION RED INSERTADO CON EXITO"   
            } 
        UUID   = if( "ERROR EN MODULO" -eq (Getuuid))     { 
                    Write-Host "ERROR EN MODULO UUID MAL"  $Paths.UUID   -ForegroundColor Red | Getuuid     
                }else{ 
                    (Getuuid)
                    Add-Content -Path $lgPath  -Value "DATA UUID INSERTADO CON EXITO"     
            } 
        TMZONE = if( "ERROR EN MODULO" -eq (Gettimezone)) { 
                    Write-Host "ERROR EN MODULO TMZONE MAL"$Paths.TMZONE -ForegroundColor Red | Gettimezone 
                }else{ 
                    (Gettimezone)
                    Add-Content -Path $lgPath  -Value "DATA TIMEZONE AJUSTADO INSERTADO CON EXITO" 
                } 
        MKDATE = Get-Date | Select-Object year, day, month
    }

    Write-Host "Exportando Informacion"                                 -ForegroundColor Cyan

    if ((Export-Objecttojson -OutPath $PathReportWName -DataIn $ObjectSend) -eq 1){ 

        $msg = "Creacion de JSON para auditoria Exitosa $PathReportWName.json"
        Write-Host $msg                                                 -ForegroundColor Green
        Add-Content -Path $lgPath -Value $msg

    }else{
        $msg = "No Fue Posible crear JSON para auditoria"

        Write-Host $msg                                                  -ForegroundColor red
        Exit 1
    }

} # endIf

else{

    $msg = "NO SE PUDO CREAR INFORME ERROR AL CARGAR MODULOS"
    Write-Host $msg
}




#$php = php -m 
#$php | ConvertTo-Json 

# $Archivo = "C:\Reportes\log.txt"
# Add-Content -Path $Archivo -Value "Nuevo registro"