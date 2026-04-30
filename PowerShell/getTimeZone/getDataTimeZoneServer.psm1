

function Gettimezone{

    Get-TimeZone | Select-Object Id, DisplayName, StandardName, DaylightName

}

Export-ModuleMember Gettimezone
