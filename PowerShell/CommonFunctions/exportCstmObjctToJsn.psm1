

function Export-Objecttojson{

    param(
        [string]$OutPath,
        [Object]$DataIn,
        [int]$dept 
    )

    try{
        $DataIn | ConvertTo-JSON -Depth 6 | Out-File -Encoding UTF8 "$OutPath.json"
        return 1
    }catch{
        return 0
    }
    
}

Export-ModuleMember Export-Objecttojson
