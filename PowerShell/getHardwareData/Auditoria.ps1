param(
    [int]$depth
)

# Este Script Obtiene la información de CPU y la manda imprimir en un formato determinado
# en el directorio repositorio para que los palicativos de auditoria puedan consulatrla

$RetunExp = 0
$Eject = 1
$msj = ""
$localpath     = (get-Location).Path
$localpathback = Split-Path $localpath -Parent

$Paths = @{
    EXPORT = "$localpathback\FuncionesComunes\exportCstmObjctToJsn.psm1"
    CPU    = "$localpath\getDataCPUModule.psm1"
    RAM    = "$localpath\getDataRAMModule.psm1"
    DISC   = "$localpath\getDataDISKModule.psm1"
    EQPMET = "$localpath\getDataEQPModule.psm1"
    NET    = "$localpath\getDataNETModule.psm1"
    FDISK  = "$localpath\getDataFDISKModule.psm1"
    IPCNF  = "$localpath\getDataIPNTModule.psm1"
    UUID   = "$localpath\getDataUIDModule.psm1"
    TMZONE = "$localpathback\getTimeZone\getDataTimeZoneServer.psm1"
}

foreach($fls in $paths.GetEnumerator()){
    
    $Clave = $fls.Key
    $Valor = $fls.Value


    if( Test-Path $fls.Value ){

        Write-Host "Comprobando existencia de Archivo con modulo:  $Clave" -ForegroundColor  Green

    }else{

        $Eject = 0
        Write-Host "Comprobando existencia de Archivo con modulo:  $Clave  ERROR" -ForegroundColor  Red
        $msj = "Error al Comprobar la ruta del archivo:  $Valor"

    }
}

if($Eject -eq 1){

    # Import of Common Funtions
    Import-Module -Name "$localpathback\FuncionesComunes\exportCstmObjctToJsn.psm1"

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


    # Path of repository Directory
    $PathRepository = "$localpathback\RepositoryDocsPS"

    $date = Get-Date -Format "MMddyyyy"
    #Path of Respository with name
    $OutPath = "$PathRepository\auditoria_hardware"

    # Creating an Object 
    # Including searching of errors inside body data
    $ObjectSend = [PSCustomObject]@{
        CPU    = if( "ERROR EN MODULO" -eq (Getcpu))      { Write-Host "ERROR EN MODULO CPU MAL:" $Paths.CPU     -ForegroundColor Red | Getcpu      }else{ (Getcpu)      } 
        RAM    = if( "ERROR EN MODULO" -eq (Getram))      { Write-Host "ERROR EN MODULO RAM MAL"   $Paths.RAM    -ForegroundColor Red | Getram      }else{ (Getram)      } 
        DISC   = if( "ERROR EN MODULO" -eq (Getdisk))     { Write-Host "ERROR EN MODULO DISC MAL"  $Paths.DISC   -ForegroundColor Red | Getdisk     }else{ (Getdisk)     } 
        EQPMET = if( "ERROR EN MODULO" -eq (Geteqp))      { Write-Host "ERROR EN MODULO EQPMET MAL"$Paths.EQPMET -ForegroundColor Red | Geteqp      }else{ (Geteqp)      } 
        NET    = if( "ERROR EN MODULO" -eq (Getnetadp))   { Write-Host "ERROR EN MODULO NET MAL"   $Paths.NET    -ForegroundColor Red | Getnetadp   }else{ (Getnetadp)   } 
        FDISK  = if( "ERROR EN MODULO" -eq (Getfdisk))    { Write-Host "ERROR EN MODULO FDISK MAL" $Paths.FDISK  -ForegroundColor Red | Getfdisk    }else{ (Getfdisk)    } 
        IPCNF  = if( "ERROR EN MODULO" -eq (Getipnet))    { Write-Host "ERROR EN MODULO IPCNF MAL" $Paths.IPCNF  -ForegroundColor Red | Getipnet    }else{ (Getipnet)    } 
        UUID   = if( "ERROR EN MODULO" -eq (Getuuid))     { Write-Host "ERROR EN MODULO UUID MAL"  $Paths.UUID   -ForegroundColor Red | Getuuid     }else{ (Getuuid)     } 
        TMZONE = if( "ERROR EN MODULO" -eq (Gettimezone)) { Write-Host "ERROR EN MODULO TMZONE MAL"$Paths.TMZONE -ForegroundColor Red | Gettimezone }else{ (Gettimezone) } 
        MKDATE = Get-Date | Select-Object year, day, month
    }


    # repository Exist ??
    if( Test-Path $PathRepository ){

        Write-Host "Comprobando carpeta de reporte $PathRepository"    -ForegroundColor Cyan
        Write-Host "Exportando Informacion"                            -ForegroundColor Cyan

        # Yes! Send the info to print 
        if ((Export-Objecttojson -Depth $depth  -OutPath $OutPath -DataIn $ObjectSend) -eq 1){ 
            Write-Host "Creacion de JSON para auditoria Exitosa"        -ForegroundColor Green
        }else{
            Write-Host "No Fue Posible crear JSON para auditoria"        -ForegroundColor red
        }

    }else{

        # No! first create the direcotry
        New-Item -ItemType "Directory" -Path $PathRepository -Force | Out-Null
        Write-Host "Creando carpeta de reporte $PathRepository"       -ForegroundColor Cyan
        
        
        Write-Host "Exportando Informacion"                           -ForegroundColor Cyan
        
        # Them send yhe info to print
        if ((Export-Objecttojson -Depth $depth  -OutPath $OutPath -DataIn $ObjectSend) -eq 1){ 
            Write-Host "Creacion de JSON para auditoria Exitosa"               -ForegroundColor Green
        }else{
            Write-Host "No Fue Posible crear JSON para auditoria Creado"       -ForegroundColor Red
        }

    }
} # endIf

else{

    Write-Host "NO SE PUDO CREAR INFORME DE AUDITORIA - CONSULTE LOG  "       
    -ForegroundColor Red

    Write-Host $msj

}

$php = php -m
$php | ConvertTo-Json

# $Archivo = "C:\Reportes\log.txt"
# Add-Content -Path $Archivo -Value "Nuevo registro"