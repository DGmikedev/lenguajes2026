function Getram{
    Get-CimInstance Win32_PhysicalMemory | Select-Object Capacity
}

Export-ModuleMember Getram
