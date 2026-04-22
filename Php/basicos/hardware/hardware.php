<?php


/*    TABLA DE COMANDOS
---------------------------------------------------------------------------------
Información                     Linux                                   Windows
---------------------------------------------------------------------------------
CPU	                            lscpu                                   wmic cpu get name,NumberOfCores,NumberOfLogicalProcessors
Memoria RAM	                    free -h                                 wmic memorychip get capacity
Disco duro	                    df -h                                   wmic logicaldisk get size,freespace,caption
Información del sistema	        uname -a o php_uname()	                systeminfo o php_uname()
Red / IP	                    ip addr	                                ipconfig /all
MAC Address	                    ip link o ip addr	                    getmac
Procesos activos	            ps aux	                                tasklist
Uso de CPU en tiempo real	    top o htop	                            wmic cpu get loadpercentage
Uso de memoria en tiempo real	free -h / top	                        tasklist / systeminfo
Temperatura CPU	                sensors	                                (más complejo, suele requerir wmic avanzado o software externo)
Serial de disco	                lsblk -o NAME,SERIAL	                wmic diskdrive get serialnumber
UUID del servidor	            cat /sys/class/dmi/id/product_uuid	    wmic csproduct get UUID
Número de núcleos	            nproc	                                wmic cpu get NumberOfCores
Servicios activos	            systemctl list-units --type=service	    sc query
Usuarios conectados	            who	                                    query user
------------------------------------------------------------------------------------
*/


$plataforma = PHP_OS_FAMILY;


// echo shell_exec("wmic memorychip get capacity");


$parametros = [
    "CPU Nombre" =>                    ["lscpu",                               "wmic cpu get name"],
    "CPU Numero de nucleos" =>         ["lscpu",                               "wmic cpu get NumberOfCores"],
    "CPU #Procesadores logicos" =>     ["lscpu",                               "wmic cpu get NumberOfLogicalProcessors"],
    "Memoria RAM" =>                   ["free -h",                             "wmic memorychip get capacity"],
    "Partición (es)" =>                ["df -h",                               "wmic logicaldisk get size, freespace, caption"],
    "Información sistema" =>           ["uname -a",                            "systeminfo"],
    "Red / IP" =>                      ["ip addr",                             "ipconfig /all"],
    "MAC Address" =>                   ["ip link",                             "getmac /fo csv /nh"],
    "Procesos activos" =>              ["ps aux",                              "tasklist"],
    "Uso de CPU en tiempo real" =>     ["top",                                 "wmic cpu get loadpercentage"],
    "Uso de memoria en tiempo real" => ["free -h / top",                       "tasklist / systeminfo"],
    "Serial de disco" =>               ["lsblk -o NAME,SERIAL",                "wmic diskdrive get serialnumber"],
    "UUID del servidor" =>             ["cat /sys/class/dmi/id/product_uuid",  "wmic csproduct get UUID"],
    "Número de núcleos" =>             ["nproc",                               "wmic cpu get NumberOfCores"],
    "Servicios activos" =>             ["systemctl list-units --type=service", "sc query"],
    "Usuarios conectados" =>           ["who",                                 "query user"]
];

function execCommand($command){
    return $out_c = shell_exec($command);
}

function strToArray($str){
    $valores = array_values(
            array_filter(
                array_map('trim', $str)
            )
    );
    return $valores;
}

// crea un atabla para la MAC address
function tableMAC($arry){

    $tabla = "<table   style=\"width: 90%; margin: left; text-align: left;\">
            <thead>
                <tr>
                    <th style:\" width:40%;  text-align:left;\">Dirección Física</th>
                    <th style:\" width:60%;  text-align:left;\">Nombre Transporte</th>

                </tr>
            </thead><tbody>";

    foreach($arry as $clave => $valor)
    {
        $valorA = explode(",",$valor);
        $tabla .= "<tr>
            <td>".str_ireplace("\"","",$valorA[0])."</td>
            <td>".str_ireplace("\"","",$valorA[1])."</td>

            </tr>";
    }

    $tabla .= "</tbody></table>";

    return $tabla;
}


// crea una tabla para las particiones del disco
function tableParticion($strDisk){

    $arrT = [];
    $row_cap = explode("\n",execCommand("wmic logicaldisk get caption"));
    $row_size = explode("\n",execCommand("wmic logicaldisk get size"));
    $row_freespace = explode("\n",execCommand("wmic logicaldisk get freespace"));

    for($indexCap = 0; $indexCap < count($row_cap); $indexCap++)
    {
        $arrT[0][$indexCap] = $row_cap[$indexCap];
    }

    for($indexSize = 0; $indexSize < count($row_size); $indexSize++)
    {
        $arrT[1][$indexSize] = $row_size[$indexSize];
    }

    for($indexSpace = 0; $indexSpace < count($row_freespace); $indexSpace++)
    {
        $arrT[2][$indexSpace] = $row_freespace[$indexSpace];
    }

    $tabla = "<table   style=\"width: 60%; margin: left; text-align: left;\">
            <thead>
                <tr>
                    <th style:\" width:20%;  text-align:left;\">Partición</th>
                    <th style:\" width:40%;  text-align:left;\">Tamaño</th>
                    <th style:\" width:40%;  text-align:left;\">Espacio libre</th>

                </tr>
            </thead><tbody>";

    for($i = 1; $i < count($arrT[0]); $i++)
    {
        if(strlen($arrT[0][$i]) == 1 || strlen($arrT[0][$i]) == 0 )
            {

            }else{
                $tabla .= "<tr>
                    <td>".$arrT[0][$i]."</td>
                    <td>".$arrT[1][$i]."</td>
                    <td>".$arrT[2][$i]."</td>
                    <tr>";
            }
        
    }

    $tabla .= "</tbody></table>";

    return $tabla;

}


// crea un tabla con los valores de la memoria
function tableRAM($valStrg){

    $tabla = "<table>";

    for($i = 1; $i < count($valStrg); $i++){

        $tabla .= "<tr><td> Módulo $i <td> <td> Cap: ". $valStrg[$i]."</td></tr>";

    }

    $tabla .= "</table>";

    return $tabla;
}



function execCommandToArray($val){
    return explode("\n",execCommand($val));
}

?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr".".net/npm/@tailwindcss/browser@4"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@300;400;500;700&display=swap" rel="stylesheet"><title>server</title>
    <style>
        body{ background-color:#F5F5F4; 
        font-family: 'JetBrains Mono', monospace;
        font-size: 12px;
        }


    </style>
    
</head>
<body>
    
<div class="h-screen flex flex-col items-center justify-center bg-gray-100">

  <!-- Contenedor principal -->
  <div class="w-[70%] h-[90%] bg-white shadow-lg rounded-lg flex flex-col">

    <!-- Título -->
    <div class="p-4 border-b text-center">
      <div>
        <h3 class="mt-3 text-4xl tracking-tighter sm:text-4xl text-pretty">
            VARIABLES CON INFORAMCIÓN DEL SERVIDOR
        </h3>
    </div>
    </div>

    <!-- Tabla -->
    <div class="flex-1 overflow-auto p-4">
      <table   style="width: 90%; margin: auto; text-align: left;  border: 1px solid #F5F5F4;">
        
        <thead  style="background-color:#7BF1A8;">
          <tr>
            <th style="width: 30%;">VARIABLE</th>
            <th style="width: 70%;">SALIDA</th>
          </tr>
        </thead>

        <tbody>
            <?php
                
                $fbg = 0;
                
                $cbg = "#E2E8F0;";
                
                foreach($parametros as $clave => $valor){ 
                    
                    $fbg % 2 == 0 ? $fbg = 1 : $fbg = 0; 
                    
                    $fbg == 0 ? $cbg = "#ECFDF5;" : $cbg = "white";

                    $value_return  = match ($clave){
                        "Información sistema" => "LINK - INFORMACION SISTEMAS",

                        "Red / IP" => "LINK RED - IP",

                        "Procesos activos" => "LINK RED - PROCESOS ACTIVOS",

                        "Servicios activos" => "LINK RED - SERVICIO ACTIVOS",

                        // Bloque
                        "CPU Nombre",
                        "CPU Numero de nucleos",
                        "CPU #Procesadores logicos" => strToArray(explode("\n",execCommand($valor[1])))[1],
                        "Partición (es)" => tableParticion($valor[1]), 
                        "Memoria RAM"  => tableRAM( strToArray(execCommandToArray($valor[1])) ),  

                        "MAC Address" => tableMAC(strToArray(explode("\n",execCommand($valor[1])))),

                        "Uso de CPU en tiempo real" ,
                        "Uso de memoria en tiempo real" ,
                        "Serial de disco" ,
                        "UUID del servidor" ,
                        "Número de núcleos" ,
                        "Usuarios conectados"  => execCommand($valor[1])
                    };    
                    echo "  
                        <tr style=\" background-color:$cbg;\">
                          <td>" . $clave ." :</td>
                          <td>" . $value_return . "</td>
                        </tr>";   
                }  
            ?>  
        </tbody>

      </table>
    </div>


  </div>
</div>

</body>
</html>