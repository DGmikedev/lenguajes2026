<?php

  $metodos = [
      "construct" => '__construct() | PARA DECLARAR UN CONSTRUCTOR DE CLASE',
      "destruct" => '__destruct() | PARA DESTRUIR UN OBJETO DE CLASE',
      "clone" => '__clone() | PARA CLONAR UN OBJETO DE CLASE',
      "call" => '__call() | PARA  ',
      "callStatic" => '__callStatic()',
      "get" => '__get()',
      "set" => '__set()',
      "isset" => '__isset()',
      "unset" => '__unset()',
      "serialize" => '__serialize()',
      "unserialize" => '__unserialize()',
      "sleep" => '__sleep()',
      "wakeup" => '__wakeup()',
      "toString" => '__toString()',
      "invoke" => '__invoke()',
      "set_state" => '__set_state()',
      "debugInfo" => '__debugInfo()'
  ];

?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr XXXborrar las x´s y juntar xxx .net/npm/@tailwindcss/browser@4"></script>
    <title>métodos mágicos</title>
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
            MÉTODOS MÁGICOS
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
            foreach($metodos as $clave => $valor){
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