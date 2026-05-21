# Obtiene los datos de la zona horaria ajustada en el servidor
#

# Opciones:
# json => crea un archivo con timezones en formato json
# txt => crea un archivo con timezones en formato txt
# cmd => crea un archivo con timezones e imprime en pantalla


param(
    [string]$Out
)

if($Out -eq "json"){
    Get-TimeZone | ConvertTo-JSON -Depth 3 |
    Out-File -Encoding UTF8 getTimeZoneDataServe.json
    Write-Host "1"
}elseif($Out -eq "txt"){
    Get-TimeZone | Out-File -Encoding UTF8 getTimeZoneDataServe.txt
    Write-Host "1"
}elseif($Out -eq "cmd"){
    Write-Host(Get-TimeZone)
}else{
    Write-Host "parametros no validos"
    Write-Host "0"
}
