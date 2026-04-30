function Getram{

    try{ 
        $ram = Get-CimInstance Win32_PhysicalMemory | 
        Select-Object Capacity
        return $ram
    }catch{
        
        return "ERROR EN MODULO"
    }
}

Export-ModuleMember Getram
