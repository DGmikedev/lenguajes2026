
function Getcpu{
    try{
    $cpu = Get-CimInstance Win32_Processor | 
    Select-Object Caption, 
    Description, InstallDate, Name, Status, Availability, 
    CreationClassName, DeviceID, 
    SystemCreationClassName,
    SystemName,AddressWidth,CurrentClockSpeed,DataWidth,
    LoadPercentage,Role,Manufacturer, 
    MaxClockSpeed,SocketDesignation, NumberOfCores, 
    NumberOfLogicalProcessors
    return $cpu
    }catch{

        return "ERROR EN MODULO"
    }

}

Export-ModuleMember -Function Getcpu
 