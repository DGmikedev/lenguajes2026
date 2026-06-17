function New-CollectionDirectory{

    # Adding Windows Form
    Add-Type -AssemblyName System.Windows.Forms

    # Menu Select path directory
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog

    try{

        $dialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK  

        return $dialog.SelectedPath

    }catch{

        return "Error en la seleccion de directorio [$($_.Exception.Message)]"

    }

}

Export-ModuleMember New-CollectionDirectory

