Add-Type -AssemblyName PresentationFramework

[xml]$xaml = Get-Content ".\xamls\mainWindow.xaml"  -Raw

$reader = New-Object System.Xml.XmlNodeReader $xaml

$window = [Windows.Markup.XamlReader]::Load($reader)

$BtnOpenFileBrowser = $window.FindName("BtnOpenFileBrowser")

$ComboAlgorith      = $window.FindName("ComboAlgorith")

$BtnLaunchCompare   = $window.FindName("BtnLaunchCompare")

$TxBoxPathFile      = $window.FindName("TxBoxPathFile")

$TxBoxInHash        = $window.FindName("TxBoxInHash")

$LblFileName        = $window.FindName("LblFileName")

$ChkBoxGenerateHash = $window.FindName("ChkBoxGenerateHash")

$script:GenerateHash = $false

function messagepopup{
    param(
        [string]$msg,
        [string]$status
    )

    [System.Windows.Input.Mouse]::OverrideCursor = $null

    if($status -eq "valido"){

        [System.Windows.MessageBox]::Show($msg,
            "VALIDACION EXITOSA!",
            [System.Windows.MessageBoxButton]::OK,
            [System.Windows.MessageBoxImage]::Information
        )

    }elseif($status -eq "incompleto"){

        [System.Windows.MessageBox]::Show(
            $msg,
            "INTEGRE INFORAMCION",
            [System.Windows.MessageBoxButton]::OK,
            [System.Windows.MessageBoxImage]::Warning
        )

    }elseif($status -eq "invalido"){

        [System.Windows.MessageBox]::Show(
            $msg,
            "NO SUPERO LA VALIDACION",
            [System.Windows.MessageBoxButton]::OK,
            [System.Windows.MessageBoxImage]::Error
        )
    }elseif($status -eq "genrador"){

        [System.Windows.MessageBox]::Show($msg,
            "GENERACION DE HASH EXITOSA",
            [System.Windows.MessageBoxButton]::OK,
            [System.Windows.MessageBoxImage]::Information
        )

    }else{

        Write-Host "Estado INVALIDO"

    }
}

  
function ClearFormulary{

    $ComboAlgorith.SelectedIndex = 0
    $TxBoxPathFile.Text = ""
    $TxBoxInHash.Text = ""
    $LblFileName.Text = ""

}


function filePicker{

    Add-Type -AssemblyName System.Windows.Forms

    $filePicker = New-Object System.Windows.Forms.OpenFileDialog

    $result = $filePicker.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {

        return $filePicker.FileName

    }

    return $null

}

function validate{
    

    $script:status = $false

    $script:msg = ""

    if( $TxBoxPathFile.text.Length -le 1 ){

        $script:msg = "Seleccione un Archivo para comparar"

        $script:status = "incompleto"

    }elseif(

        $TxBoxInHash.text.length -le 1 -and 

        $script:GenerateHash -eq $false
    ){

        $script:msg = "Inserte un valor HASH para comparar"

        $script:status = "incompleto"


    }elseif( $ComboAlgorith.SelectedItem.Content.ToString() -eq "SELECT" ){
    
        $script:msg = "Seleccione un Algoritmo Valido para comparar"

        $script:status = "incompleto"

    }else{

        if($script:GenerateHash){

            $TxBoxInHash.Text = (GenerateHashes)

        }else{

            (CompareHashes)

        }

    }

    messagepopup -msg $script:msg -status $script:status
}


function GenerateHashes{

    $meth = $ComboAlgorith.SelectedItem.Content.ToString()

    $values = @{
        path = $TxBoxPathFile.text
        algo = $meth
    }

    $hashFile = Get-FileHash $values.path  -Algorithm $values.algo

    $hashFileClean = $hashFile.Hash.Trim().ToUpperInvariant()

    $script:msg = "Metodo: $meth ::`n`n$($hashFileClean)`n`n----------------------`n`nCOPIE DE CAMPO DE TEXTO GET / INSERT HASH"

    $script:status = "genrador"

    return $hashFileClean
}

function CompareHashes{

  $meth = $ComboAlgorith.SelectedItem.Content.ToString()

        $values = @{

            path = $TxBoxPathFile.text

            algo = $meth

        }

        $hashFile = Get-FileHash $values.path  -Algorithm $values.algo

        $hashFileClean = $hashFile.Hash.Trim().ToUpperInvariant()

        $hashAlphnumer = $TxBoxInHash.Text.Trim().ToUpperInvariant()

        $script:msg = "Metodo: $meth ::`n`n$($hashFileClean) `n`n--------------------`n`n$hashAlphnumer"

        if($hashFileClean -eq $hashAlphnumer){

            $script:status = "valido"

        }else{

            $script:status = "invalido"
            
        }

}

$BtnOpenFileBrowser.Add_Click({

    $TxBoxPathFile.Text = (filePicker)

})

$BtnLaunchCompare.Add_Click({

    [System.Windows.Input.Mouse]::OverrideCursor = [System.Windows.Input.Cursors]::Wait

    (validate)

})

$ChkBoxGenerateHash.Add_Click({

    if( $ChkBoxGenerateHash.IsChecked ){

        $script:GenerateHash = $true

    }else{

        $script:GenerateHash = $false

    }

})

$window.ShowDialog()

