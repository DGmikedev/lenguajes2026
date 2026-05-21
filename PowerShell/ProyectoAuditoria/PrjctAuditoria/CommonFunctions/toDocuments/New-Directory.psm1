param(
    [string]$path,
    [string]$nameDir
)

function New-Directory($path, $nameDir){

    # Validated Parent path
    $path_validated = pathValidator -path $path

    if($path_validated){

        try{

            New-Item -ItemType "Directory" -Path "$path\$nameDir" -ErrorAction Stop -Force | Out-Null 

            $MsjR=@{

                RESULTADO =  1
                PATH = "$path$nameDir"
            }

            return $MsjR | ConvertTo-JSON  


        }catch{

            $msg = $_.Exception.Message

            $MsjR=@{

                RESULTADO = 0
                PATH = $msg
            }

            return $MsjR | ConvertTo-JSON  
            
        }


    }else{

            $MsjR=@{
                    RESULTADO = 0
                    PATH = "hubo problemas al validar el Path del directorio"
            }

            return $MsjR | ConvertTo-JSON  

    }

    

}


function pathValidator($path){

    if((Test-Path -Path $path))
    { 
        return $true
    
    }else{ 
        return $false 
    }

}

Export-ModuleMember New-Directory

