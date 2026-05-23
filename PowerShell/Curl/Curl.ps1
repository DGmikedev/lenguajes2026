Add-Type -AssemblyName PresentationFramework

[xml]$xaml = Get-Content ".\window.xaml" -Raw

$reader = New-Object System.Xml.XmlNodeReader $xaml

$window = [Windows.Markup.XamlReader]::Load($reader)

$url = $window.FindName("TxtUrl")

$btnSend = $window.FindName("BtnSend")

$CmbMethod = $window.FindName("CmbMethod")

$BlocTextResponse = $window.FindName("BlocTextResponse")

$BlocTextHeaders = $window.FindName("BlocTextHeaders")

$btnSend.Add_Click({

    try{

        $Response = Invoke-WebRequest -Uri $url.Text

        $json = $Response | ConvertFrom-JSON | ConvertTo-JSON -Depth 10

        $head = $Response.Headers

        $BlocTextHeaders.Text = (
            $head | ForEach-Object{
                Write-Host "$($_.Key) : $($_.Value)"
            }
        ) -join "`r`n"
        

       
    }catch{

        $json = $_.Exception.Message

    }
  
    $BlocTextResponse.Text = $json

})

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