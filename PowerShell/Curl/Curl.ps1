Add-Type -AssemblyName PresentationFramework

[xml]$xaml = Get-Content ".\window.xaml" -Raw

$reader = New-Object System.Xml.XmlNodeReader $xaml

$window = [Windows.Markup.XamlReader]::Load($reader)


<#
    Configuración de las variables 
    del ajuste de formulario:
    
    setFormulary( 
                
                $CmbMethod       $TxtUrl,          $BtnSend,
                $CmbBody,        $CmbHeaders,      $TextCurl,        
                $BtnSave,        $TxtHeadersRtrn,  $TxtBodyResponse, 
                $TxtBodyReq,     $TxtHeadersReq 
            )  
#>
    function setFormulary($status){

        $CmbMethod.IsEnabled       = $status[0]
        $TxtUrl.IsEnabled          = $status[1]
        $BtnSend.IsEnabled         = $status[2]
        $CmbBody.IsEnabled         = $status[3]
        $CmbHeaders.IsEnabled      = $status[4]
        $TextCurl.IsEnabled        = $status[5]
        $BtnSave.IsEnabled         = $status[6]
        $TxtHeadersRtrn.IsEnabled  = $status[7]
        $TxtBodyResponse.IsEnabled = $status[8]
        $TxtBodyReq.IsEnabled      = $status[9]
        $TxtHeadersReq.IsEnabled   = $status[10]

    }
    function clearFormulary(){
    
        $TxtUrl.Text = ""
        $TextCurl.Text = ""
        $TxtHeadersRtrn.Text = ""
        $TxtBodyResponse.Text = ""
        $TxtBodyReq.Text = ""
        $TxtHeadersReq.Text = ""
        $CmbBody.SelectedIndex = 0
        $CmbHeaders.SelectedIndex = 0

    }

    function setArrayStatusForm($setForm){

        switch ($setForm) {

            "APAGADO"   { 
                            (clearFormulary)
                            setFormulary($true ,$false ,$false ,$false ,$false ,$false ,$false ,$false ,$false ,$false, $false) 
                        }

            "SND_GET_POST" {
                            (clearFormulary)
                            setFormulary($true ,$true ,$true ,$true ,$true ,$false ,$true ,$true ,$true ,$false, $false) 
                        }

            "SND_CURL"  { 
                            (clearFormulary)
                            setFormulary($true ,$false ,$true ,$false ,$false ,$true ,$true ,$true ,$true ,$false, $false) 
                        }

            default { 
                    Write-Host "ATENCION CON SELECCION: " $setForm      -ForeigroundColor Red
            }
        }

    }

    function buildRequest(){

        $params = @{}

        if($TxtBodyReq.Text -eq "YES"){
            $params.Add( "Body" , $TxtBodyReq.Text)
        }

        $params.Add("Uri",              $TxtUrl.Text)
        $params.Add("SessionVariable",  'Session')
        $params.Add("Method",           $CmbMethod.SelectedItem.Content.ToString())

        return $params

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

    <#  PRIMER DESPLIEGUE DE FORMULARIO 
        TODO APAGADO
    #>
    
    setArrayStatusForm("APAGADO")


    $CmbMethod.Add_SelectionChanged({
        
        switch($CmbMethod.SelectedItem.Content){

            "NO"  { setArrayStatusForm("APAGADO") }

            "GET" { setArrayStatusForm("SND_GET_POST") }

            "POST" { setArrayStatusForm("SND_GET_POST") }

            "CURL" { setArrayStatusForm("SND_CURL") }

            default { Write-Host "SELECCION - DEAFULT"  }
        }

    })

    $CmbBody.Add_SelectionChanged({

        switch($CmbBody.SelectedItem.Content){
            "YES"   { 
                $TxtBodyReq.IsEnabled = $true
                $TxtBodyReq.Text = ""
             }
            "NO"    {
                $TxtBodyReq.Text = ""
                $TxtBodyReq.IsEnabled = $false
                
            }
            default {}
        }
        
    })

    $CmbHeaders.Add_SelectionChanged({

        switch($CmbHeaders.SelectedItem.Content){
            "YES"   { 
                $TxtHeadersReq.IsEnabled = $true
                $TxtHeadersReq.Text = ""
             }
            "NO"    {
                $TxtHeadersReq.Text = ""
                $TxtHeadersReq.IsEnabled = $false
                
            }
            default {}
        }
        
    })

    

    
    $BtnSend.Add_Click({

        [hashtable]$paramsReturned = (buildRequest)
        $responseArr = @{}

        try{

            $response = Invoke-WebRequest @paramsReturned -ErrorAction Stop

            $responseBody = $response | ConvertFrom-JSON |ConvertTo-JSON -Depth 6

            $responseArr.Add("BodyResponse", $responseBody)

            $responseArr.Add("Status",       $response.StatusCode)


            $TxtBodyResponse.text = $responseArr.BodyResponse


            Write-Host $response.StatusCode

        }catch{

            $msg = $_.Exception.Message

        }

    })





    
        

    # $BtnSend
    # $CmbBody
    # $CmbHeaders
    # $TextCurl
    # $BtnSave
    # $TxtHeadersRtrn
    # $TxtBodyResponse
    # $TxtHeadersReq
    
    
    
    
    
    
    
    
    
    
    




$window.ShowDialog()
