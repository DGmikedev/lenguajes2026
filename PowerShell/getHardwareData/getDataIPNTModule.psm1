function Getipnet{

    try {
        $dat1    = [PSCustomObject]@{

            IPV4     = Get-NetIPAddress -AddressFamily IPv4 | Select-Object InterfaceAlias, IPAddress
            ADAPTERS = Get-NetIPConfiguration | Select-Object  InterfaceDescription

        }

        return $dat1

    }catch{

        return "ERROR EN MODULO"
    }

}

Export-ModuleMember Getipnet

