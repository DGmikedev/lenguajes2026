<?php

// ARRAY CON INFORMACIÓN DEL SERVIDOR
$server = $_SERVER;
/////////////////////////////////////


?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivrXXXborrarxxx.net/npm/@tailwindcss/browser@4"></script>
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
            foreach($server as $clave => $valor){
                echo "
                    <tr class='border-b hover:bg-gray-100'>
                      <td class='px-6 py-4'>" . $clave ."</td>
                      <td class='px-6 py-4'>" .$valor . "</td>
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