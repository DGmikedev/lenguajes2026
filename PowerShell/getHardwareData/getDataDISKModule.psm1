function Getdisk{
    Get-CimInstance Win32_LogicalDisk | 
    Select-Object DeviceID, Size, FreeSpace
}

Export-ModuleMember Getdisk