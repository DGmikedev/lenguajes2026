function Get-SetWindowBody{

    param( [hashtable]$Controls )

    $parent =  Split-Path $PSSCriptRoot -Parent


    [xml]$xaml = Get-Content "$parent\Xamls\windowSetBodyReqst.xaml" -Raw

    $reader = New-Object System.Xml.XmlNodereader $xaml

    $windowSetBody = [Windows.Markup.XamlReader]::Load($reader)

    $script:BtnSetValueHeader = $windowSetBody.FindName("BtnSetValueHeader")
    $script:TxtBodyReq        = $windowSetBody.FindName("TxtBodyReq")

    $BtnSetValueHeader.Add_Click({
        Write-Host "[$($script:TxtBodyReq.Text)]"
    })


    $windowSetBody.ShowDialog()
}

Export-ModuleMember Get-SetWindowBody

