function Geteqp{

    try{
        
        $eqp = Get-ComputerInfo | 
        Select-Object WindowsInstallDateFromRegistry, WindowsProductName, 
        WindowsRegisteredOwner, WindowsSystemRoot, BiosBIOSVersion, BiosListOfLanguages, 
        CsDNSHostName, CsDomain, CsName, CsNetworkAdapters, CsProcessors, CsSystemType, CsUserName,
        CsWorkgroup, OsOperatingSystemSKU, OsVersion, OsSystemDirectory, OsSystemDrive, OsWindowsDirectory,
        OsManufacturer, OsMuiLanguages, TimeZone

     return $eqp

    }catch{

        return "ERROR EN MODULO"
    }
}


Export-ModuleMember Geteqp