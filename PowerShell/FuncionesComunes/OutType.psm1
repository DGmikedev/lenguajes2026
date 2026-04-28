function Type-Out{
    param (
        [string]$OutType, 
        [string]$OutPath,
        [string]$Text
    )


    if($OutType -eq "json"){

        $Text | ConvertTo-Json -Depth 3 | Out-File $OutPath
        Write-Host "1"

    }else{
        Write-Host $PRO
    }

}


Export-ModuleMember -Function Type-Out