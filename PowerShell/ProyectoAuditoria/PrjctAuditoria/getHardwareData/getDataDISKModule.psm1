function Getdisk{
    try{
    
        $disk = Get-CimInstance Win32_LogicalDisk | 
        Select-Object DeviceID, Size, FreeSpace
        return $disk

    }catch{

        return "ERROR EN MODULO"
    }
    
}

Export-ModuleMember Getdisk