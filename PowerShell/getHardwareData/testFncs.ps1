param(
    [string]$Tipo
)

# importamos las funciones comunes
Import-Module -Name "C:\Users\El JEFE\Desktop\DESARROLLO\lenguajes\PowerShell\FuncionesComunes\OutType.psm1"
Import-Module -Name "C:\Users\El JEFE\Desktop\DESARROLLO\lenguajes\PowerShell\getHardwareData\getDataCPUModule.psm1"

$OutType = $Tipo 
$OutPath = "miText.json"
$Text    = Getcpu


Type-Out  -OutType $OutType -OutPath $OutPath -Text $Text



