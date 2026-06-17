function Get-SetWindowBody{

    param( [hashtable]$Controls )

    $parent =  Split-Path $PSSCriptRoot -Parent
    $script:StrBody = ""


    [xml]$xaml = Get-Content "$parent\Xamls\windowSetBodyReqst.xaml" -Raw

    $reader = New-Object System.Xml.XmlNodereader $xaml

    $windowSetBody = [Windows.Markup.XamlReader]::Load($reader)

    $script:BtnSetValueHeader = $windowSetBody.FindName("BtnSetValueHeader")
    $script:TxtBodyReq        = $windowSetBody.FindName("TxtBodyReq")
    $script:TxtMsgBody        = $windowSetBody.FindName("TxtMsgBody")

    $script:StrBody = $Controls["TxtBodyReq"].Text 
    $script:BtnSetValueHeader.IsEnabled = $false

    # Validation input body
    $script:TxtBodyReq.Add_SelectionChanged({

        $script:StrBody = $script:TxtBodyReq.Text -replace  '\r?\n' , ''

        $script:StrBody = $StrBody -replace '\\u0027' , "'"    
       

            try{

                $script:StrBody = $script:StrBody | ConvertFrom-JSON | ConvertTo-JSON

                $script:TxtBodyReq.Foreground  =  [System.Windows.Media.Brushes]::Black

                if(!($script:StrBody.Length -eq 0)){

                    $script:TxtMsgBody.Foreground  =  [System.Windows.Media.Brushes]::Green

                    $script:TxtMsgBody.Text = "Validated"

                    $script:TxtBodyReq.Text = $script:StrBody

                    $script:BtnSetValueHeader.IsEnabled = $true

                }else{

                    $script:BtnSetValueHeader.IsEnabled = $false

                }

            }catch{

                $script:TxtMsgBody.Foreground  =  [System.Windows.Media.Brushes]::Red

                $script:TxtMsgBody.Text = $_.Exception.Message

                $script:TxtBodyReq.Foreground  =  [System.Windows.Media.Brushes]::Red

                $script:BtnSetValueHeader.IsEnabled = $false

            }

    })

    $BtnSetValueHeader.Add_Click({
        
        $Controls["TxtBodyReq"].Text = $script:StrBody 

        $windowSetBody.Close()

    })


    $windowSetBody.ShowDialog()
}

Export-ModuleMember Get-SetWindowBody

