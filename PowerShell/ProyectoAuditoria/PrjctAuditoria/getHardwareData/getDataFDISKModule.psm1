function Getfdisk{
    
    try{
        $disk =  Get-CimInstance Win32_DiskDrive | 
        Select-Object Caption, partitions, 
        Size, Model
        return $disk

    }catch{

        return "ERROR EN MODULO"
    }
    
}

Export-ModuleMember Getfdisk