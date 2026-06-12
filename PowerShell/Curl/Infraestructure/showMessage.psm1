#Add-Type -AssemblyName PresentationFramework

function showMessage(){

    param(
        [string]$Message
    )

    [System.Windows.MessageBox]::Show($Message)

}

Export-ModuleMember showMessage