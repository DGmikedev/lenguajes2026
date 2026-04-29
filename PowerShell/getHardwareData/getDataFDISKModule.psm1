function Getfdisk{
    Get-CimInstance Win32_DiskDrive | 
    Select-Object Caption, partitions, 
    Size, Model
}

Export-ModuleMember Getfdisk