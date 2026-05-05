param(
    [string]$name,
    [string]$path,
    [string]$value 
)

$ValidPath = $false

function Create-Document($name, $path, $value){

    # $MsjR = [PSCustomObject]@{}

    if ( pathValidator($path) )
    {
        try{

            New-Item -ItemType "File" -Name $name -Path $path -Value $value -ErrorAction Stop

            
            $MsjR=@{

                RESULTADO =  1
                MENSAJE = "Docuemento creado: $path\$name"
            }

        }catch{

            $msg = $_.Exception.Message

            $MsjR=@{

                RESULTADO = 0
                MENSAJE = $msg
            }
        }
    }else{
        $MsjR=@{
            RESULTADO =  0
            MENSAJE = "hubo problemas al validar el Path del documento"
        }
    }

             return $MsjR | ConvertTo-JSON  

} # end function 


function pathValidator($path){

    if((Test-Path -Path $path))
    { 
        return $true
    
    }else{ 
        return $false 
    }

}

Export-ModuleMember Create-Document

#create_document -name $name -path $path -value $value
