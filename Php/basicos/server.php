<?php


$sName = $_SERVER["SERVER_NAME"];
$rTime = $_SERVER["REQUEST_TIME"];





$jsonObj = [
    [
        "name"  => "SERVER_NAME",
        "valor" => $sName,
        "desc" => "Devuelve le nombre del servidor que en el que vive el aplicativo"
    ],
    [
        "name"  => "REQUEST_TIME",
        "valor" => $rTime,
        "desc" => "Numero de segundos en el sistema"
    ]
];

// $varObj = json_decode($jsonObj);





?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
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
            <th class="px-6 py-3 text-left text-sm font-semibold">FUNCIÓN</th>
          </tr>
        </thead>

        <tbody class="bg-white">
        <?php
        foreach($jsonObj as $obj){
            echo "
          <tr class='border-b hover:bg-gray-100'>
            <td class='px-6 py-4'>" . $obj["name"]  ."</td>
            <td class='px-6 py-4'>" . $obj["valor"] ."</td>
            <td class='px-6 py-4'>" .$obj["desc"] . "</td>
          </tr>";
        }
        ?>  
        </tbody>

      </table>
    </div>

  </div>

</div>
<!--
    <div>
        <h3 class="mt-3 text-4xl tracking-tighter sm:text-6xl text-pretty">VARIABLES CON INFORAMCIÓN DEL SERVIDOR</h3>
        <br>
    </div>
    <div class="overflow-x-auto">
  <table class="min-w-full border border-gray-200 rounded-lg overflow-hidden">
    <thead class="bg-gray-800 text-white">
      <tr>
        <th class="px-6 py-3 text-left text-sm font-semibold">VARIABLE</th>
        <th class="px-6 py-3 text-left text-sm font-semibold">FUNCIÓN</th>
      </tr>
    </thead>
    <tbody class="bg-white">
    <?php  /*
        foreach($jsonObj as $obj){
            echo "
            <tr class='border-b hover:bg-gray-100'>
                <td class='px-6 py-4'>".$obj['name']."</td>
                <td class='px-6 py-4'>".$obj['valor']."</td>
            </tr> ";
        }  */
    ?>
      
      <tr class="border-b hover:bg-gray-100">
        <td class="px-6 py-4">Ana López</td>
        <td class="px-6 py-4">ana@email.com</td>

      </tr>
    </tbody>
  </table>
</div>
-->
</body>
</html>