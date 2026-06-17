function Get-AddWindowHeader{

    param( [hashtable]$controlsIn )

    $parent =  Split-Path $PSSCriptRoot -Parent

    Import-Module "$parent\Infraestructure\showMessage.psm1"

    $controls = $controlsIn

    $HeadersParamsTMP = ""

    [xml]$xalm = Get-Content "$parent\Xamls\windowAddHeader.xaml" -Raw

    $reader = New-Object System.Xml.XmlNodereader $xalm

    $windowAddHeader = [Windows.Markup.XamlReader]::Load($reader)


    $CmbParamHead      = $windowAddHeader.FindName("CmbParamHead")
    $TxtValueHeader    = $windowAddHeader.FindName("TxtValueHeader")
    $BtnSetValueHeader = $windowAddHeader.FindName("BtnSetValueHeader")


    $BtnSetValueHeader.Add_Click({

        # Validación de parametros ajustados

        if( $CmbParamHead.SelectedItem.Content -eq "PARAM" ){

            showMessage  -Message "SELECCIONE UN METODO PARA EL ENCABEZADO DEL REQUEST"

        }elseif( $TxtValueHeader.Text -eq ""){

            showMessage -Message "INGRESE EL VALOR PARA EL PARAMETRO ELEGIDO"

        }else{
        
            $controls["TxtHeadersReq"].Text = ""
        
            $controls["HeadersParams"].Add([PSCustomObject]@{
                Key   = "$($CmbParamHead.SelectedItem.Content)"
                Value = "$($TxtValueHeader.Text)"
            })

            $CmbParamHead.SelectedIndex = 0
            
            $TxtValueHeader.Text = ""

            foreach($item in $controls["HeadersParams"]){

                $HeadersParamsTMP += "{`n`"$($item.Key)`" :`n`"$($item.Value)`"`n}`n--------------------`n"

                $controls["TxtHeadersReq"].Text += $HeadersParamsTMP

                $HeadersParamsTMP = ""

            }

            #(setHeadersParam)
                
        }

    }) #BtnSetValueHeader

    $windowAddHeader.ShowDialog()
}

Export-ModuleMember Get-AddWindowHeader

