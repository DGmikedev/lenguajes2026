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

        $CmbMethod.IsEnabled         = $status[0]
        $TxtUrl.IsEnabled            = $status[1]
        $BtnSend.IsEnabled           = $status[2]
        #$CmbBody.IsEnabled           = $status[3]
        #$CmbHeaders.IsEnabled        = $status[4]
        $BtnAddBody.IsEnabled        = $status[3]
        $BtnAddHeader.IsEnabled      = $status[4]
        $TextCurl.IsEnabled          = $status[5]
        $BtnSave.IsEnabled           = $status[6]
        $TxtHeadersRtrn.IsEnabled    = $status[7]
        $TxtBodyResponse.IsEnabled   = $status[8]
        $TxtBodyReq.IsEnabled        = $status[9]
        $TxtHeadersReq.IsEnabled     = $status[10]
        $BtnMnsHead.IsEnabled        = $status[11]  
        $BtnMnsBody.IsEnabled        = $status[12]
        $BtnNewCollection.IsEnabled  = $status[13]

    }

    function clearFormulary(){
    
        $TxtUrl.Text = ""
        $TextCurl.Text = ""
        $TxtHeadersRtrn.Text = ""
        $TxtBodyResponse.Text = ""
        $TxtBodyReq.Text = ""
        $TxtHeadersReq.Text = ""
        #$CmbBody.SelectedIndex = 0
        #$CmbHeaders.SelectedIndex = 0

    }

    <#  Habilita o deshabilita los componentes de formulario 
        dependiendo del estado que requiera el request
    #>
    function setArrayStatusForm($setForm){

        # $CmbMethod.IsEnabled         = $status[0]
        # $TxtUrl.IsEnabled            = $status[1]
        # $BtnSend.IsEnabled           = $status[2]
        # $BtnAddBody.IsEnabled        = $status[3]
        # $BtnAddHeader.IsEnabled      = $status[4]
        # $TextCurl.IsEnabled          = $status[5]
        # $BtnSave.IsEnabled           = $status[6]
        # $TxtHeadersRtrn.IsEnabled    = $status[7]
        # $TxtBodyResponse.IsEnabled   = $status[8]
        # $TxtBodyReq.IsEnabled        = $status[9]
        # $TxtHeadersReq.IsEnabled     = $status[10]
        # $BtnMnsHead.IsEnabled        = $status[11]
        # $BtnMnsBody.IsEnabled        = $status[12]
        # $BtnNewCollection.IsEnabled  = $status[13]

        switch ($setForm) {
                                    
            "APAGADO"   { 
                            (clearFormulary)
                                        #[0]    [1]     [2]     [3]     [4]     [5]     [6]     [7]     [8]     [9]     [10]    [11]    [12]    [13]
                            setFormulary($true ,$false ,$false ,$false ,$false ,$false ,$false ,$false ,$false ,$false, $false, $false, $false, $false) 
                        }
                                    
            "GET" {
                            (clearFormulary)
                                        #[0]    [1]    [2]    [3]     [4]     [5]     [6]    [7]   [8]     [9]     [10]    [11]    [12]    [13]
                            setFormulary($true ,$true ,$true ,$false ,$false ,$false ,$true ,$true ,$true ,$false, $false, $false, $false, $true) 
                        }
            "POST" {
                            (clearFormulary)
                                        #[0]    [1]    [2]    [3]    [4]    [5]     [6]    [7]    [8]    [9]     [10]    [11]   [12]   [13]
                            setFormulary($true ,$true ,$true ,$true ,$true ,$false ,$true ,$true ,$true ,$false, $false, $true, $true, $true) 
                        }
            "PATCH" {
                            (clearFormulary)
                                        #[0]    [1]    [2]    [3]    [4]    [5]     [6]    [7]    [8]    [9]     [10]    [11]   [12]   [13]
                            setFormulary($true ,$true ,$true ,$true ,$true ,$false ,$true ,$true ,$true ,$false, $false, $true, $true, $true) 
                        }
            "PUT" {
                            (clearFormulary)
                                        #[0]    [1]    [2]    [3]    [4]    [5]     [6]    [7]    [8]    [9]     [10]    [11]   [12]   [13]
                            setFormulary($true ,$true ,$true ,$true ,$true ,$false ,$true ,$true ,$true ,$false, $false, $true, $true, $true) 
                        }
            "DELETE" {
                            (clearFormulary)
                                        #[0]    [1]    [2]    [3]    [4]    [5]     [6]    [7]    [8]    [9]     [10]    [11]   [12]   [13]
                            setFormulary($true ,$true ,$true ,$true ,$true ,$false ,$true ,$true ,$true ,$false, $false, $true, $true, $true) 
                        }
            "SND_CURL"  { 
                            (clearFormulary)
                                        #[0]    [1]     [2]    [3]    [4]     [5]     [6]    [7]     [8]     [9]     [10]    [11]    [12]    [13]
                            setFormulary($true ,$false ,$true ,$false ,$false ,$true ,$true ,$false ,$false ,$false, $false, $false, $false, $true) 
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
    #$CmbBody         = $window.FindName("CmbBody")
    #$CmbHeaders      = $window.FindName("CmbHeaders")
    $TextCurl        = $window.FindName("TextCurl")
    $BtnSave         = $window.FindName("BtnSave")
    $TxtHeadersRtrn  = $window.FindName("TxtHeadersRtrn")
    $TxtBodyResponse = $window.FindName("TxtBodyResponse")
    $TxtBodyReq      = $window.FindName("TxtBodyReq")
    $TxtHeadersReq   = $window.FindName("TxtHeadersReq")
    $BtnAddBody      = $window.FindName("BtnAddBody")
    $BtnAddHeader    = $window.FindName("BtnAddHeader")
    $BtnMnsHead      = $window.FindName("BtnMnsHead")
    $BtnMnsBody      = $window.FindName("BtnMnsBody")
    $BtnNewCollection= $window.FindName("BtnNewCollection")

    <#  PRIMER DESPLIEGUE DE FORMULARIO 
        TODO APAGADO
    #>
    
    setArrayStatusForm("APAGADO")


    $CmbMethod.Add_SelectionChanged({
        
        switch($CmbMethod.SelectedItem.Content){

            "NO"     { setArrayStatusForm("APAGADO")     }
       
            "GET"    { setArrayStatusForm("GET")         }
      
            "POST"   { setArrayStatusForm("POST")        }
     
            "PATCH"  { setArrayStatusForm("PATCH")       }
     
            "PUT"    { setArrayStatusForm("PUT")         }
    
            "DELETE" { setArrayStatusForm("DELETE")      }
   
            "CURL"   { setArrayStatusForm("SND_CURL")    }

            default  { Write-Host "SELECCION - DEAFULT"  }
        }

    })

    <# $CmbBody.Add_SelectionChanged({

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
        
    }) #>

    <#
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
        
    }) #>
    
    $BtnSend.Add_Click({

        $responseArr = @{}

        if($CmbMethod.SelectedItem.Content -eq "CURL" ){

            $cUrl = " $($TextCurl.text) "

            $Invoke = Invoke-Curl2PS $cUrl 

            $response = Invoke-WebRequest @Invoke

            $responseBody = $response | ConvertFrom-JSON |ConvertTo-JSON -Depth 6
            $responseArr.Add("BodyResponse",      $responseBody)
            $responseArr.Add("Status",            $response.StatusCode)
            $responseArr.Add("StatusDescription", $response.StatusDescription)
            $responseArr.Add("Headers",           $response.Headers)
            $responseArr.Add("RawContent",        $response.RawContent)

            #$responseArr.Session
            #Write-Host $responseArr.RawContent

            $headersT = ""
            $headersT += "========`n"
            $headersT += "ESTATUS CODE: " + $responseArr.Status + " ::  " +  $responseArr.StatusDescription
            $headersT += "`n========`n"
            foreach($key in $responseArr.Headers.Keys){
                $headersT += "`n========`n"
                $headersT += $key
                $headersT += "`n"
                $headersT += $responseArr.Headers[$key]
                $headersT += "`n========`n"
            }
            $responseArr.Add("Session", $Session)
            Write-Host $responseArr.Status
            Write-Host $responseArr.StatusDescription
            $TxtBodyResponse.text = $responseBody
            $TxtHeadersRtrn.Text =  $headersT



        }else{

            try{

                [hashtable]$paramsReturned = (buildRequest)

                $response = Invoke-WebRequest @paramsReturned -ErrorAction Stop

                $responseBody = $response | ConvertFrom-JSON |ConvertTo-JSON -Depth 6
                $responseArr.Add("BodyResponse",      $responseBody)
                $responseArr.Add("Status",            $response.StatusCode)
                $responseArr.Add("StatusDescription", $response.StatusDescription)
                $responseArr.Add("Headers",           $response.Headers)
                $responseArr.Add("RawContent",        $response.RawContent)

                #$responseArr.Session
                #Write-Host $responseArr.RawContent

                $headersT = ""
                $headersT += "========`n"
                $headersT += "ESTATUS CODE: " + $responseArr.Status + " ::  " +  $responseArr.StatusDescription
                $headersT += "`n========`n"
                foreach($key in $responseArr.Headers.Keys){
                    $headersT += "`n========`n"
                    $headersT += $key
                    $headersT += "`n"
                    $headersT += $responseArr.Headers[$key]
                    $headersT += "`n========`n"
                }
                $responseArr.Add("Session", $Session)
                Write-Host $responseArr.Status
                Write-Host $responseArr.StatusDescription

                $TxtBodyResponse.text = $responseBody
                $TxtHeadersRtrn.Text =  $headersT

            }catch{

                $msg = $_.Exception.Message

            }

        }

    })

$window.ShowDialog()

