function Export-Data{
    param (
        [string]$OutType, 
        [string]$OutPath,
        [Object]$DataIn
    )

    # Select Type of exportation
    if($OutType -eq "json"){

        $DataIn | ConvertTo-Json -Depth 6 | Out-File -Encoding UTF8 "$OutPath.json"

        # out to return 
        Write-Host "1"

    }elseif( $OutType -eq "txt" ){

        $DataIn | Format-List * | Out-File -Encoding UTF8 "$OutPath.txt"

        # out to return 
        Write-Host "1"

    }elseif($OutType -eq "cmd"){

        # out to return 
        Write-Host $DataIn

    }else{

        # out to return 
        Write-Host "Parametros no validos"
    }
}

Export-ModuleMember -Function Export-Data