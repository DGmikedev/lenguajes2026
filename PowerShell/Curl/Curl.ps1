Add-Type -AssemblyName PresentationFramework

[xml]$xaml = Get-Content ".\window.xaml" -Raw

$reader = New-Object System.Xml.XmlNodeReader $xaml

$window = [Windows.Markup.XamlReader]::Load($reader)

# Se Obtienen los valores del formulario

$url = $window.FindName("TxtUrl")

$btnSend = $window.FindName("BtnSend")

$CmbMethod = $window.FindName("CmbMethod")

$BlocTextResponse = $window.FindName("BlocTextResponse")

$BlocTextHeaders = $window.FindName("BlocTextHeaders")

$BlocTextHeadersReturn = $window.FindName("BlocTextHeadersReturn")


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

