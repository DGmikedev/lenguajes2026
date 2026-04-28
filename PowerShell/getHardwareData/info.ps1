# Obtiene datos de hardware en servidor

param( [string]$Device,
    [string]$Out
)

$ObjOut = [PScustomObject]@{}

$DocRepo = "RepositoryDocs"
$PathPadre = Split-Path $PSScriptRoot -Parent

Write-Line $PathPadre

$NameFile = ""
$Full_Path = ""

if($Device -eq "cpu"){
    $PRO = Get-CimInstance Win32_Processor | 
    Select-Object Caption, 
    Description, InstallDate, Name, Status, Availability, 
    CreationClassName, DeviceID, 
    SystemCreationClassName,
    SystemName,AddressWidth,CurrentClockSpeed,DataWidth,
    LoadPercentage,Role,Manufacturer, 
    MaxClockSpeed,SocketDesignation, NumberOfCores, 
    NumberOfLogicalProcessors

    $NameFile = "cpuInfor.json"

    $Full_Path = Join-Path $Docrepo $NameFile                # Carpeta contenedora
    $Full_Path = Join-Path  (Get-Location).Path $Full_Path   # Adjunta el Localización en servidor
    $Full_Path = $Full_Path

    Write-Host $Full_Path

}else{
    Write-Host "opcion no valida"
}





#$objOut | -ConvertTo-Json -Depth 3 |
#Out-File -Encoding UTF8 InfoHardwareServer.json













































#$obj = [PSCustomObject]@{
#    
#    CPU = Get-CimInstance Win32_Processor |
#        Select-Object Name, NumberOfCores, NumberOfLogicalProcessors, LoadPercentage
#
#    RAM = Get-CimInstance Win32_PhysicalMemory |
#        Select-Object Capacity
#
#    Discos = Get-CimInstance Win32_LogicalDisk |
#        Select-Object DeviceID, Size, FreeSpace
#
#    Sistema = Get-ComputerInfo
#
#    Red = Get-NetIPConfiguration
#
#    MAC = Get-NetAdapter |
#        Select-Object Name, MacAddress
#
#    Procesos = Get-Process |
#        Select-Object ProcessName, Id, CPU, WorkingSet
#
#    SerialDisco = Get-CimInstance Win32_DiskDrive |
#        Select-Object SerialNumber
#
#    UUID = Get-CimInstance Win32_ComputerSystemProduct |
#        Select-Object UUID
#
#    NucleosCPU = (Get-CimInstance Win32_Processor).NumberOfCores
#}
#
## Convertir a JSON
#$obj | ConvertTo-Json -Depth 6 |
#    Out-File -Encoding UTF8 hardware.json



#
#Write-Host "Archivo generado correctamente: hardware.json"
#
#
##$obj = [PScustomObject]@{}
#
#if($Tipo -eq "cpu"){
#    $obj | Get-CimInstance Win32_Processor | Select-Object Name, numberOfCores, NumberOfLogicalProcessors, LoadPercentage 
#    
#}elseif($Tipo -eq "ram"){
#    $obj | Get-CimInstance Win32_PhysicalMemory | Select-Object Capacity
#}else{
#    write-Host "opción no valida"
#}