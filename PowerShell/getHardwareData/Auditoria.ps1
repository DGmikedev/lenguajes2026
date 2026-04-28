param(
    [string]$Tipo
)

# Este Script Obtiene la informaci�n de CPU y la manda imprimir en un formato determinado
# en el directorio repositorio para que los palicativos de auditoria puedan consulatrla


$localpath     = (get-Location).Path
$localpathback = Split-Path $localpath -Parent

# Import of Common Funtions
Import-Module -Name "$localpathback\FuncionesComunes\OutType.psm1"


# Module  Get Data CPU 
Import-Module -Name "$localpath\getDataCPUModule.psm1"
# Module Get Data RAM
Import-Module -Name "$localpath\getDataRAMModule.psm1"
# Module Get Data Disk
Import-Module -Name "$localpath\getDataDISKModule.psm1"



# Path of repository Directory
$PathRepository = "$localpathback\RepositoryDocsPS"

#Path of Respository with name
$OutPath = "$PathRepository\auditoria"

# Use of Getcpu function "get cpu data"
$ObjectSend = [PSCustomObject]@{
    CPU = Getcpu
    RAM = Getram 
    DISC = Getdisk
}


# repository Exist ??
if( Test-Path $PathRepository ){
    
    # Yes! Send the info to print 
    Export-Data -OutType $Tipo  -OutPath $OutPath -DataIn $ObjectSend

}else{

    # No! first create the direcotry
    New-Item -ItemType "Directory" -Path $PathRepository -Force | Out-Null
    
    # Them send yhe info to print
    Export-Data -OutType $Tipo  -OutPath $OutPath -DataIn $ObjectSend    
}
