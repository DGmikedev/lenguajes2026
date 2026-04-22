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
    "MAC Address" =>                   ["ip link",                             "getmac"],
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

function tableDisk($strDisk){

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

/*
    for($index = 0; $index < count($arrT); $index++)
    {
        for($j= 0; $j < count($arrT[$index]); $j++)
        {
            echo " --- " . $arrT[$index][$j] . "---- <br>";    
        }
        
    }
*/

    $tabla = "<table>
            <thead>
                <tr>
                    <th>Caption</th>
                    <th>Size</th>
                    <th>FreeSpace</th>

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
    

    // var_dump($arrT);
/*
    array(3) { 
        [0]=> array(8) 
          { [0]=> string(10) "Caption " 
            [1]=> string(10) "C: " 
            [2]=> string(10) "D: " 
            [3]=> string(10) "E: " 
            [4]=> string(10) "F: " 
            [5]=> string(10) "G: " 
            [6]=> string(1) " " 
            [7]=> string(0) "" 
          } 
        [1]=> array(8) { 
            [0]=> string(15) "Size " 
            [1]=> string(15) "970084839424 " 
            [2]=> string(15) "119225618432 " 
            [3]=> string(15) "535805952 " 
            [4]=> string(15) "28595712000 " 
            [5]=> string(15) " " 
            [6]=> string(1) " " 
            [7]=> string(0) "" 
          } 
            [2]=> array(8) { 
            [0]=> string(15) "FreeSpace " 
            [1]=> string(15) "632471392256 " 
            [2]=> string(15) "76806033408 " 
            [3]=> string(15) "535769088 " 
            [4]=> string(15) "19087413248 " 
            [5]=> string(15) " " 
            [6]=> string(1) " " 
            [7]=> string(0) "" 
        } } 
        
*/


    //echo str_ireplace(" ","X",$strDisk[3]) . " largo: " . strlen($strDisk[3]);
   /* 
   $tmp = strToArray($strDisk);
   $tmp[0] = str_ireplace(" ","X",$strDisk);
   echo "strToArray <br>";
   var_dump($tmp);
   echo "<br>-----------";
   echo count($tmp);
   echo "<br>";
    */



   

   

    return $tabla;
    // var_dump($command);
    // die("DIES DISCK");

    /*
    $disck_size = "wmic logicaldisk get size";
    $disck_free = "wmic logicaldisk get freespace";
    $disck_caption = "wmic logicaldisk get caption";

    $Size      = strToArray(explode("\n", shell_exec($disck_size) ) );
    $FreeSpace = strToArray(explode("\n", shell_exec($disck_free) ) );
    $Caption   = strToArray(explode("\n", shell_exec($disck_caption) ) );

      

    print_r($Size);
    echo "<br>";
    print_r($FreeSpace);
    echo "<br>";
    print_r($Caption);
*/
}


// crea un tabla con los valores de la memoria

function tableRAM($valStrg){

    $rows = strToArray($valStrg);

    $tabla = "<table>";

    for($i = 1; $i < count($rows); $i++){

        $tabla .= "<tr><td> Módulo $i <td> <td> Cap: ". $rows[$i]."</td></tr>";

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
    <script src="https://cdn.jsdelivr XQuitarXsX  .net/npm/@tailwindcss/browser@4"></script>
    <title>server</title>
    <style>
        body{ background-color:#F5F5F4; }
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
      <table>
        
        <thead  style="background-color:#7BF1A8;">
          <tr>
            <th style="width: 20%;">VARIABLE</th>
            <th style="width: 80%;">SALIDA</th>
          </tr>
        </thead>

        <tbody>
            <?php

                foreach($parametros as $clave => $valor){ 
                    $value_return  = match ($clave){
                        "Información sistema" => "LINK - INFORMACION SISTEMAS",

                        "Red / IP" => "LINK RED - IP",

                        "Procesos activos" => "LINK RED - PROCESOS ACTIVOS",

                        "Servicios activos" => "LINK RED - SERVICIO ACTIVOS",

                        // Bloque
                        "CPU Nombre",
                        "CPU Numero de nucleos",
                        "CPU #Procesadores logicos" => strToArray(explode("\n",execCommand($valor[1])))[1],


                        "Partición (es)" => tableDisk($valor[1]), //getHDiscData($valor[1]),


                        "Memoria RAM"  => tableRAM( execCommandToArray($valor[1]) ),  


                        "MAC Address" ,
                        "Uso de CPU en tiempo real" ,
                        "Uso de memoria en tiempo real" ,
                        "Serial de disco" ,
                        "UUID del servidor" ,
                        "Número de núcleos" ,
                        "Usuarios conectados"  => execCommand($valor[1])
                    };    
                    echo "  
                        <tr>
                          <td>" . $clave ."</td>
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