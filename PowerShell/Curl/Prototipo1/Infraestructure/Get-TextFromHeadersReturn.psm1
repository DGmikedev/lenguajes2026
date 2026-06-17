function Get-TextFromHeadersReturn{
    param(
        [hashtable]$responseArr
    )

    $headersT = ""

    $headersT += "========`n"
    $headersT += "ESTATUS CODE: " + $responseArr.Status + " ::  " +  $responseArr.StatusDescription
    $headersT += "`n========`n"
    foreach($key in $responseArr.Headers.Keys){
        $headersT += "`n========`n"
        $headersT += $key
        $headersT += "`n"
        $headersT += $responseArr.Headers[$key]
        $headersT += "`n========`n"
    }

    return $headersT
        
}

Export-ModuleMember Get-TextFromHeadersReturn

