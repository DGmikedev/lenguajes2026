

function Gettimezone{

    Get-TimeZone | Select-Object Id, DisplayName, StandardName, DaylightName

}

function GettimeHMS{
    Get-Date -Format "hh:MM:ss"
}

Export-ModuleMember Gettimezone, GettimeHMS
