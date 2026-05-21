function Getnetadp{
    
    try{
        $net = Get-NetAdapter | 
        Select-Object Name, MacAddress, InterfaceDescription, 
        Status, LinkSpeed
        return $net

    }catch{
        
        return "ERROR EN MODULO"
    }
}

Export-ModuleMember Getnetadp
