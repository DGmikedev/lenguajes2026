function Get-RmvWindowHeader{

    param( [hashtable]$controls )
    
    $parent =  Split-Path $PSSCriptRoot -Parent

    [xml]$xaml = Get-Content "$parent\Xamls\windowRemovHeader.xaml" -Raw 

        $reader = New-Object System.Xml.XmlNodereader $xaml

        $windowRmvHeaderPrm = [Windows.Markup.XamlReader]::Load($reader)

        $SpParams = $windowRmvHeaderPrm.FindName("SpParams")

        $temporalP = $controls["HeadersParams"]
       

        $updateHeaderValues = $windowRmvHeaderPrm.findName("updateHeaderValues")
        
        foreach($param in $temporalP){

            $tmpItem = "{$($param.Key) :  $($param.Value)}"

            $opcCheck = New-Object System.Windows.Controls.CheckBox

            $opcCheck.Content = $tmpItem

            $opcCheck.Margin = "5"

            $opcCheck.IsChecked = $true

            $opcCheck.Tag = @{

                Key = $param.Key

                Value = $param.Value

            }

            $SpParams.Children.Add($opcCheck)

        }

        $updateHeaderValues.Add_Click({

            $controls["TxtHeadersReq"].Text = "" 

            $controls["HeadersParams"].Clear()

            foreach($param in $SpParams.Children){

                if($param -is [System.Windows.Controls.CheckBox] -and $param.IsChecked ){
                    
                    $key   = $param.Tag.Key

                    $value = $param.Tag.Value

                    $controls["HeadersParams"].Add( [PSCustomObject]@{

                        Key = $key

                        Value = $value

                    })

                }

            }

            foreach($item in $controls["HeadersParams"]){

                $HeadersParamsTMP += "{`n`"$($item.Key)`" :`n`"$($item.Value)`"`n}`n--------------------`n"

                $controls["TxtHeadersReq"].Text += $HeadersParamsTMP

                $HeadersParamsTMP = ""

            }
            $windowRmvHeaderPrm.Close()


        })

        $windowRmvHeaderPrm.ShowDialog()   | Out-Null

}

Export-ModuleMember Get-RmvWindowHeader