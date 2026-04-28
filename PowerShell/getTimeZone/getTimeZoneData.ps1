#lista de zonas horarias disponibles  en servidor

# Opciones:
# json => crea un archivo con timezones en formato json
# txt => crea un archivo con timezones en formato txt
# cmd => crea un archivo con timezones e imprime en pantalla

param(
    [string]$Out
)

if($Out -eq "json"){
    Get-TimeZone -ListAvailable | ConvertTo-JSON -Depth 3 |
    Out-File -Encoding UTF8 ListaZonasHorarias.json
    Write-Host "1"

}elseif($Out -eq "txt"){
    Get-TimeZone -ListAvailable | Out-File -Encoding UTF8 ListaZonasHorarias.txt
    Write-Host "1"

}elseif($Out -eq "cmd"){
    Write-Host (Get-TimeZone -ListAvailable)

}else{
    Write-Host "Opcion no valida"
    Write-Host "0"
}



