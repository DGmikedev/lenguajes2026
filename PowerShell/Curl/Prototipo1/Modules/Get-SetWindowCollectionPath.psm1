function Get-SetWindowCollectionPath{

    $parent = Split-Path $PSScriptRoot -Parent

    Import-Module "$parent/Infraestructure/New-CollectionDirectory.psm1"

    [xml]$xaml = Get-Content "$parent\Xamls\windowSetPathCollection.xaml" -Raw

    $reader = New-Object System.Xml.XmlNodereader $xaml

    $windowConllection = [Windows.Markup.XamlReader]::Load($reader)

    $script:pathNC = ""        # Path new collection directory

    $BtnNewColltn  = $windowConllection.FindName("BtnNewColltn")
    $BtnLoadColltn = $windowConllection.FindName("BtnLoadColltn")
    $BtnSetColltn  = $windowConllection.FindName("BtnSetColltn")
    $TxtPathNwColl = $windowConllection.FindName("TxtPathNwColl")




    $BtnNewColltn.Add_Click({

        $script:pathNC = New-CollectionDirectory

        $TxtPathNwColl.Text = $script:pathNC

    })
    


    
    $windowConllection.ShowDialog()


}

Export-ModuleMember  Get-SetWindowCollectionPath

    <#


        Title="NEW COLLECTION" Height="367" Width="401" Background="WhiteSmoke">
<Grid>
    <Button Content="LOAD COLLECTION" HorizontalAlignment="Left" Margin="198,34,0,0" VerticalAlignment="Top" Width="170" Height="40" BorderBrush="#FFD8F1A5" Background="#FFCCED95" FontWeight="Bold"/>
    <TextBox HorizontalAlignment="Center" TextWrapping="Wrap" VerticalAlignment="Top" Width="349" Height="43" VerticalContentAlignment="Center" Margin="0,165,0,0" IsReadOnly="True" Background="#FFF1F0F0"/>
    <Button Content="UNLOAD COLLECTION" HorizontalAlignment="Center" Margin="0,260,0,0" VerticalAlignment="Top" Width="349" Height="50" Background="#FF5B2A2A" FontWeight="Bold" Foreground="#FFF1F1EF"/>
    <Separator HorizontalAlignment="Center" Margin="0,213,0,0" VerticalAlignment="Top" Height="28" Width="349"/>
    <Button Content="NEW COLLECTION" HorizontalAlignment="Left" Margin="19,34,0,0" VerticalAlignment="Top" Width="174" Height="40" Background="#FFF7E2BC" BorderBrush="#FFF5ECD7" FontWeight="Bold"/>
    <TextBox HorizontalAlignment="Center" TextWrapping="Wrap" VerticalAlignment="Top" Width="349" Height="43" VerticalContentAlignment="Center" Margin="0,106,0,0"/>
    <Label Content="Collection Name:" HorizontalAlignment="Left" Margin="19,79,0,0" VerticalAlignment="Top" Width="99"/>
</Grid>

Title="NEW COLLECTION" Height="367" Width="401" Background="WhiteSmoke">
<Grid>
    <Button Name="BtnNewColltn" Content="NEW COLLECTION" HorizontalAlignment="Left" Margin="198,34,0,0" VerticalAlignment="Top" Width="170" Height="40"/>
    <TextBox Name="TxtPathNwColl" HorizontalAlignment="Center" Margin="0,86,0,0" TextWrapping="Wrap" Text="Path .  .  ." VerticalAlignment="Top" Width="349" Height="43" VerticalContentAlignment="Center"/>
    <Button Name="BtnLoadColltn" Content="LOAD COLLECTION" HorizontalAlignment="Center" Margin="0,167,0,0" VerticalAlignment="Top" Width="349" Height="50"/>
    <Separator HorizontalAlignment="Center" Margin="0,134,0,0" VerticalAlignment="Top" Height="28" Width="349"/>
    <Button Name="BtnSetColltn" Content="SET COLLECTION" HorizontalAlignment="Left" Margin="19,34,0,0" VerticalAlignment="Top" Width="174" Height="40"/>
</Grid>













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
#>
