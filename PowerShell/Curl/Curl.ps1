Add-Type -AssemblyName PresentationFramework

[xml]$xaml = Get-Content ".\window.xaml" -Raw

$reader = New-Object System.Xml.XmlNodeReader $xaml

$window = [Windows.Markup.XamlReader]::Load($reader)


function AllOff(){

    $TxtUrl.IsEnabled = $false
    $BtnSend.IsEnabled = $false
    $CmbBody.IsEnabled = $false
    $CmbHeaders.IsEnabled = $false
    $TextCurl.IsEnabled = $false
    $BtnSave.IsEnabled = $false
    $TxtHeadersRtrn.IsEnabled = $false
    $TxtBodyResponse.IsEnabled = $false
    $TxtBodyReq.IsEnabled = $false
    $TxtHeadersReq.IsEnabled = $false

}




<#   Traduciendo Formulario (WFP) - POWERSHELL    #>

    $CmbMethod       = $window.FindName("CmbMethod")
    $TxtUrl          = $window.FindName("TxtUrl")
    $BtnSend         = $window.FindName("BtnSend")
    $CmbBody         = $window.FindName("CmbBody")
    $CmbHeaders      = $window.FindName("CmbHeaders")
    $TextCurl        = $window.FindName("TextCurl")
    $BtnSave         = $window.FindName("BtnSave")
    $TxtHeadersRtrn  = $window.FindName("TxtHeadersRtrn")
    $TxtBodyResponse = $window.FindName("TxtBodyResponse")
    $TxtBodyReq      = $window.FindName("TxtBodyReq")
    $TxtHeadersReq   = $window.FindName("TxtHeadersReq")


    <# PRIMER DESPLIEGUE DE FORMULARIO #>
    (AllOff)
    
    
    
    
    
    
    
    
    
    
 <#






$btnSend.Add_Click({

    $headers_r = ""

    try{

        # Aplicando Curl o Invoke-WebRequest
        $Response = Invoke-WebRequest -Uri $url.Text -ErrorAction Stop



        # tranforma el json que llega y lo reconfigura para la visualización 
        # Es para poner un estilo de prety de forma facíl y local 
        $json = $Response | ConvertFrom-JSON | ConvertTo-JSON -Depth 10
        $BlocTextResponse.Text = $json

        

        
       

    }catch{

        $json = $_.Exception.Message
        $BlocTextResponse.Text = $json

        $headers_r = "=====================`n"
        $headers_r += "ESTATUS CODE:`n"
        $headers_r += "SIN EXITO EN LA REQUEST"
        $headers_r += "`n=====================`n`n"
        $BlocTextHeadersReturn.Text = $headers_r

    }

    # Obteniendo las cabeceras de retorno
    # Y se le da formato todo en una sola línea de data
    # con saltos.
        $head = $Response.Headers.GetEnumerator()
       


        
 $headers_r = "=====================`n"
        $headers_r += "ESTATUS CODE:`n"
        $headers_r += "SIN EXITO EN LA REQUEST"
        $headers_r += "`n=====================`n`n"
        $BlocTextHeadersReturn.Text = $headers_r

       

        


        foreach($header in $head){
    
            $Nombre = $header.Key
            $Valor  = $header.Value

            $headers_r += "HEADER : [ $Nombre ] `n"  
            $headers_r += "VALOR : [ $Valor ]"
            $headers_r += "`n=====================`n"

        }

        $BlocTextHeadersReturn.Text = $headers_r
  
    

})

$window.ShowDialog()

#>

$window.ShowDialog()

<#
$LoginParameters = @{
    Uri             = 'https://www.contoso.com/login/'
    SessionVariable = 'Session'
    Method          = 'POST'
    Body            = @{
        User     = 'jdoe'
        Password = 'P@S$w0rd!'
    }
}
#>