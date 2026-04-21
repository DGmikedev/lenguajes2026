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
    "Disco" =>                         ["df -h",                               "wmic logicaldisk get size, freespace, caption"],
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

function getHDiscData($command){

    // $Size = [];
    // $FreeSpace = [];
    // $Caption = [];

    $disck_size = "wmic logicaldisk get size";
    $disck_free = "wmic logicaldisk get freespace";
    $disck_caption = "wmic logicaldisk get caption";

    $varCommands = [
        $disck_size,
        $disck_free,
        $disck_caption
    ];

    $Size      = explode("\n", shell_exec($disck_size) );
    $FreeSpace = explode("\n", shell_exec($disck_free) );
    $Caption   = explode("\n", shell_exec($disck_caption) );

       $valores = array_values(
            array_filter(
                array_map('trim', $Size)
            )
        );

    print_r($valores);

    echo "<br><br><br><br><br><br><br><br>";


    for($i = 0; $i < count($Size); $i++ ){

 

        echo trim(strlen( $Size[$i] )) . "<br>";
        if (trim(strlen( $Size[$i] )) != 0) echo $Size[$i]  . "   ===  " . strlen( $Size[$i] ) . "<br>";
        
        // echo $Size[$i]  ."<br>"; // .  " - " . strlen( $Size[$i] ) ."<br>";
    }

    for($i = 1; $i < count($FreeSpace); $i++ ){
            echo $FreeSpace[$i] .  ";<br>";
    }

    for($i = 1; $i < count($Caption); $i++ ){
            echo $Caption[$i] .  ";<br>";
    }
    


    die("FIN_____");
    
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
      <table class="min-w-full border border-gray-200 rounded-lg overflow-hidden">
        
        <thead  style="background-color:#7BF1A8;"class="text-black">
          <tr>
            <th class="px-6 py-3 text-left text-sm font-semibold">VARIABLE</th>
            <th class="px-6 py-3 text-left text-sm font-semibold">SALIDA</th>
          </tr>
        </thead>

        <tbody class="bg-white">
            <?php

                foreach($parametros as $clave => $valor){ 
                    $value_return  = match ($clave){
                        "Información sistema" => "LINK - INFORMACION SISTEMAS",
                        "Red / IP" => "LINK RED - IP",
                        "Procesos activos" => "LINK RED - PROCESOS ACTIVOS",
                        "Servicios activos" => "LINK RED - SERVICIO ACTIVOS",
                        "CPU Nombre",
                        "CPU Numero de nucleos",
                        "CPU #Procesadores logicos" => execCommand($valor[1]),

                        "Disco"  => getHDiscData($valor[1]),


                        "Memoria RAM" ,
                        "MAC Address" ,
                        "Uso de CPU en tiempo real" ,
                        "Uso de memoria en tiempo real" ,
                        "Serial de disco" ,
                        "UUID del servidor" ,
                        "Número de núcleos" ,
                        "Usuarios conectados"  => execCommand($valor[1])
                    };    
                    echo "  
                        <tr class='border-b hover:bg-gray-100'>
                          <td class='px-6 py-4'>" . $clave ."</td>
                          <td class='px-6 py-4'>" . $value_return . "</td>
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