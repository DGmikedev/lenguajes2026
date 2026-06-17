Add-Type -AssemblyName PresentationFramework


$location = $PSScriptRoot

Import-Module "$location\Modules\Get-InvokeFromCurl.psm1"
Import-Module "$location\Modules\Get-AddWindowHeader.psm1"
Import-Module "$location\Modules\Get-RmvWindowHeader.psm1"
Import-Module "$location\Modules\Get-SetWindowBody.psm1"
Import-Module "$location\Modules\Get-SetWindowCollectionPath.psm1"


Import-Module "$location\Infraestructure\showMessage.psm1"
Import-Module "$location\Infraestructure\Get-TextFromHeadersReturn.psm1"

<# Main window #>
[xml]$xaml  = Get-Content ".\Xamls\window.xaml"  -Raw
$reader = New-Object System.Xml.XmlNodeReader $xaml
$window = [Windows.Markup.XamlReader]::Load($reader)


<# Varaibles #>
$script:HeadersParams = New-Object System.Collections.Generic.List[Object]
$script:Bodyrequest = ""
$script:responseArr    = @{}
$script:responseBody   = @{}



function setFormulary($status){
    $CmbMethod.IsEnabled         = $status[0]
    $TxtUrl.IsEnabled            = $status[1]
    $BtnSend.IsEnabled           = $status[2]
    $BtnAddBody.IsEnabled        = $status[3]
    $BtnAddHeader.IsEnabled      = $status[4]
    $TextCurl.IsEnabled          = $status[5]
    
    $TxtHeadersRtrn.IsEnabled    = $status[7]
    $TxtBodyResponse.IsEnabled   = $status[8]
    $TxtBodyReq.IsEnabled        = $status[9]
    $TxtHeadersReq.IsEnabled     = $status[10]
    $BtnMnsHead.IsEnabled        = $status[11]  
}

function clearFormulary(){
    $TxtUrl.Text = ""
    $TextCurl.Text = ""
    $TxtHeadersRtrn.Text = ""
    $TxtBodyResponse.Text = ""
    $TxtBodyReq.Text = ""
    $TxtHeadersReq.Text = ""
    $script:HeadersParamsTMP = ""
    $script:responseArr.Clear()
    $script:responseBody = ""
}

function setArrayStatusForm($setForm){


    # $CmbMethod.IsEnabled         = $status[0]
    # $TxtUrl.IsEnabled            = $status[1]
    # $BtnSend.IsEnabled           = $status[2]
    # $BtnAddBody.IsEnabled        = $status[3]
    # $BtnAddHeader.IsEnabled      = $status[4]
    # $TextCurl.IsEnabled          = $status[5]
    # $.IsEnabled           = $status[6]
    # $TxtHeadersRtrn.IsEnabled    = $status[7]
    # $TxtBodyResponse.IsEnabled   = $status[8]
    # $TxtBodyReq.IsEnabled        = $status[9]
    # $TxtHeadersReq.IsEnabled     = $status[10]
    # $BtnMnsHead.IsEnabled        = $status[11]  
    # .IsEnabled  = $status[12]

    switch ($setForm) {
                                    
        "APAGADO"   { 
                        (clearFormulary)
                                    #[0]    [1]     [2]     [3]     [4]     [5]     [6]     [7]     [8]     [9]     [10]    [11]    [12]  
                        setFormulary($true ,$false ,$false ,$false ,$false ,$false ,$false ,$false ,$false ,$false, $false, $false, $false) 
                    }
                                
        "GET" {
                        (clearFormulary)
                                    #[0]    [1]    [2]    [3]     [4]     [5]     [6]    [7]   [8]     [9]     [10]    [11]    [12] 
                        setFormulary($true ,$true ,$true ,$false ,$false ,$false ,$true ,$true ,$true ,$false, $false, $false, $true) 
                    }
        "POST" {
                        (clearFormulary)
                                    #[0]    [1]    [2]    [3]    [4]    [5]     [6]    [7]    [8]    [9]     [10]    [11]   [12]
                        setFormulary($true ,$true ,$true ,$true ,$true ,$false ,$true ,$true ,$true ,$true, $true, $true, $true) 
                    }
        "PATCH" {
                        (clearFormulary)
                                    #[0]    [1]    [2]    [3]    [4]    [5]     [6]    [7]    [8]    [9]     [10]    [11]   [12] 
                        setFormulary($true ,$true ,$true ,$true ,$true ,$false ,$true ,$true ,$true ,$true, $true, $true, $true) 
                    }
        "PUT" {
                        (clearFormulary)
                                    #[0]    [1]    [2]    [3]    [4]    [5]     [6]    [7]    [8]    [9]     [10]    [11]   [12]
                        setFormulary($true ,$true ,$true ,$true ,$true ,$false ,$true ,$true ,$true ,$true, $true, $true, $true) 
                    }
        "DELETE" {
                        (clearFormulary)
                                    #[0]    [1]    [2]    [3]    [4]    [5]     [6]    [7]    [8]    [9]     [10]    [11]   [12]
                        setFormulary($true ,$true ,$true ,$true ,$true ,$false ,$true ,$true ,$true ,$true, $true, $true, $true) 
                    }
        "SND_CURL"  { 
                        (clearFormulary)
                                    #[0]    [1]     [2]    [3]    [4]     [5]     [6]    [7]    [8]    [9]     [10]   [11]    [12]
                        setFormulary($true ,$false ,$true ,$false ,$false ,$true ,$true ,$true ,$true ,$false, $false, $false, $true) 
                    }

        default { 
                Write-Host "ATENCION CON SELECCION: " $setForm      -ForeigroundColor Red
        }
    }
}

function BuildCurl(){

    $ToCurl = "curl -X "

    if($CmbMethod.SelectedItem.Content -eq "GET"){

        $ToCurl += " GET "

        $ToCurl += " `"$($TxtUrl.Text)`" "

        return $ToCurl

    }else{

        $ToCurl += " $($CmbMethod.SelectedItem.Content.ToString()) "

        $ToCurl += " `"$($TxtUrl.Text)`" "

        if($script:HeadersParams.Count -ne 0){

            $script:HeadersParams | Foreach-Object({

                $ToCurl += " -H `"$($_.Key): $($_.Value)`" "

            })

        }

        if($TxtBodyReq.Text.Length -ne 0){

            $BodyFix = $TxtBodyReq.Text -replace "\r?\n" , ""

            $ToCurl += "-d `'$BodyFix`'"

        }

        return $ToCurl

    }
      
}

<#  Starting Formulary Values  #>

    $CmbMethod       = $window.FindName("CmbMethod")
    $TxtUrl          = $window.FindName("TxtUrl")
    $BtnSend         = $window.FindName("BtnSend")
    $TextCurl        = $window.FindName("TextCurl")
    $TxtHeadersRtrn  = $window.FindName("TxtHeadersRtrn")
    $TxtBodyResponse = $window.FindName("TxtBodyResponse")
    $TxtBodyReq      = $window.FindName("TxtBodyReq")
    $TxtHeadersReq   = $window.FindName("TxtHeadersReq")
    $BtnAddBody      = $window.FindName("BtnAddBody")
    $BtnAddHeader    = $window.FindName("BtnAddHeader")
    $BtnMnsHead      = $window.FindName("BtnMnsHead")

$BtnSend.Add_Click({

    $script:responseBody = ""
    $script:responseArr.Clear()

    if($CmbMethod.SelectedItem.Content -eq "CURL" ){

        $cUrl = "$($TextCurl.text)"

        
        <# Translate Curl to Invoke-WebRequest Params #>
        $Invoke = Get-InvokeFromCurl -cUrl $cUrl

        <# Get the request from Invoke  #>
        $response = Invoke-WebRequest @Invoke

        <# 
            Translate to JSON To represent data in 
            TextBox Response_Body
        #>
        $script:responseBody = $response | ConvertFrom-JSON |ConvertTo-JSON -Depth 6

        <# Setting the body request value #>
        $TxtBodyResponse.text = $script:responseBody

        <# Make array whit data to show in TextBox Headers Return #>
        $script:responseArr.Add("BodyResponse",      $script:responseBody)
        $script:responseArr.Add("Status",            $response.StatusCode)
        $script:responseArr.Add("StatusDescription", $response.StatusDescription)
        $script:responseArr.Add("Headers",           $response.Headers)
        $script:responseArr.Add("RawContent",        $response.RawContent)
        $script:responseArr.Add("Session", $Session)

        $TxtHeadersRtrn.Text = Get-TextFromHeadersReturn -responseArr $script:responseArr
 
    }else{

        try{

            $Curl = (BuildCurl)

            <# Translate Curl to Invoke-WebRequest Params #>
            $Invoke = Get-InvokeFromCurl -cUrl $cUrl

            $response = Invoke-WebRequest @Invoke -ErrorAction Stop

            $script:responseBody = $response | ConvertFrom-JSON |ConvertTo-JSON -Depth 6

            $TxtBodyResponse.text = $script:responseBody

            $script:responseArr.Add("BodyResponse",      $script:responseBody)
            $script:responseArr.Add("Status",            $response.StatusCode)
            $script:responseArr.Add("StatusDescription", $response.StatusDescription)
            $script:responseArr.Add("Headers",           $response.Headers)
            $script:responseArr.Add("RawContent",        $response.RawContent)

            $TxtHeadersRtrn.Text = Get-TextFromHeadersReturn -responseArr $script:responseArr

        }catch{

                $msg = $_.Exception.Message
                
                showMessage($msg) 

        }

        }

})

$BtnAddBody.Add_Click({

    $controls = @{

        Bodyrequest = $script:Bodyrequest

        TxtBodyReq = $TxtBodyReq

     }
    
    Get-SetWindowBody -Controls $controls

})

$BtnMnsHead.Add_Click({

    $controls = @{

        TxtHeadersReq = $TxtHeadersReq

        HeadersParams = $script:HeadersParams

    }

    Get-RmvWindowHeader -controls $controls

}) #$BtnMnsHead

$BtnAddHeader.Add_Click({

    $exportControls = @{

        TxtHeadersReq = $TxtHeadersReq

        HeadersParams = $script:HeadersParams

    }

    Get-AddWindowHeader -controls $exportControls
 
})  # Add BtnAddHeader


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



    $window.showDialog()

 