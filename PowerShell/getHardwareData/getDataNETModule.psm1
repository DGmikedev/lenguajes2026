function Getnetadp{
    Get-NetAdapter | 
    Select-Object Name, MacAddress, InterfaceDescription, 
    Status, LinkSpeed
}

Export-ModuleMember Getnetadp
