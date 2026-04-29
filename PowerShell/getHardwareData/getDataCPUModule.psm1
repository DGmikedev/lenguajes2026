
function Getcpu{
    Get-CimInstance Win32_Processor | 
    Select-Object Caption, 
    Description, InstallDate, Name, Status, Availability, 
    CreationClassName, DeviceID, 
    SystemCreationClassName,
    SystemName,AddressWidth,CurrentClockSpeed,DataWidth,
    LoadPercentage,Role,Manufacturer, 
    MaxClockSpeed,SocketDesignation, NumberOfCores, 
    NumberOfLogicalProcessors
}

Export-ModuleMember -Function Getcpu
 