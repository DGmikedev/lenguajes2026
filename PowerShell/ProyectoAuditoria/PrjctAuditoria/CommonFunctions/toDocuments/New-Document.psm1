param(
    [string]$name,
    [string]$path,
    [string]$value 
)

$ValidPath = $false

function New-Document($name, $path, $value){

    # Test if the docuemnt log already
    $pathd = Join-Path $path $name  

    if(-not(Test-Path $pathd) ){

        if ( pathValidator($path) )
        {
            try{

                New-Item -ItemType "File" -Name $name -Path $path -Value $value -ErrorAction Stop | Out-Null 


                $MsjR=@{

                    RESULTADO =  1
                    PATH = "$path\$name"
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
                RESULTADO =  0
                PATH = "hubo problemas al validar el Path del documento"
            }

            return $MsjR | ConvertTo-JSON  
        }

    }else{

        $MsjR=@{
                RESULTADO =  2
                PATH = "$path\$name"
        }

        return $MsjR | ConvertTo-JSON  
    }

} # end function 


function pathValidator($path){

    if((Test-Path -Path $path))
    { 
        return $true
    
    }else{ 

        return $false 
    }

}

Export-ModuleMember New-Document

