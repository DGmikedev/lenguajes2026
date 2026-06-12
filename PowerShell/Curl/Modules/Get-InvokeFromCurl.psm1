function Get-InvokeFromCurl(){
    param(
        [string]$cUrl
    )

    return Invoke-Curl2PS $cUrl 

}

Export-ModuleMember Get-InvokeFromCurl