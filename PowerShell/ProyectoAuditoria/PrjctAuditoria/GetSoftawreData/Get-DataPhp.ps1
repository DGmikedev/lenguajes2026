$modules = php -m
$version = php -v

$phpdata = [PSCustomObject]@{
    MODULOS = $modules 
    VERSION = $version 
}


Write-Host $phpdata

#
#$php | ConvertTo-Json 

# $Archivo = "C:\Reportes\log.txt"
# Add-Content -Path $Archivo -Value "Nuevo registro"