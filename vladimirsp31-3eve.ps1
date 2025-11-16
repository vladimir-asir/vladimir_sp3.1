# 1. Definimos una variable de control para iniciar el menú
$ejecutarMenu = $true

# Bucle principal del menú
while ($ejecutarMenu -eq $true) {
    Clear-Host # Limpia la pantalla para mostrar el menú de forma clara
    
    # Presentar el menú de acciones al usuario
    Write-Host "--- REVISOR DE EVENTOS ---"
    Write-Host "0. Salir"
    Write-Host "1. Registros del SO (Sistema)"
    Write-Host "2. Registros de Apps instaladas"
    Write-Host "3. Registros de Auditoria y Seguridad"
    Write-Host "----------------------------"

    # Capturar la entrada del teclado del usuario
    $tipoRegistro = Read-Host "Selecciona el numero del log a visualizar (0, 1, 2 o 3)"

    # Evaluar la elección del usuario
    if ($tipoRegistro -eq "0") {
        # Opción 0: Salir del script
        Write-Host "Saliendo del programa..."
        # Cambiamos la variable de control a False para detener el bucle
        $ejecutarMenu = $false
    }
    elseif ($tipoRegistro -eq "1") {
        # Opción 1: Obtener los 12 eventos más recientes del log del Sistema
        Write-Host "Recuperando los 12 eventos mas recientes del log de Sistema..."
        Get-EventLog -LogName System -Newest 12
    }
    elseif ($tipoRegistro -eq "2") {
        # Opción 2: Obtener los 12 eventos más recientes del log de Aplicaciones
        Write-Host "Recuperando los 12 eventos mas recientes del log de Aplicaciones..."
        Get-EventLog -LogName Application -Newest 12
    }
    elseif ($tipoRegistro -eq "3") {
        # Opción 3: Obtener los 12 eventos más recientes del log de Seguridad
        Write-Host "Recuperando los 12 eventos mas recientes del log de Seguridad..."
        Get-EventLog -LogName Security -Newest 12
    }
    else {
        # Bloque de control para entradas no válidas
        Write-Host "ERROR: Opcion incorrecta. Debes elegir 0, 1, 2 o 3."
    }

    # Pausa antes de volver a mostrar el menú, solo si NO se ha elegido la opción 0 (Salir)
    if ($ejecutarMenu -eq $true) {
        Write-Host "" # Añade una línea en blanco
        Read-Host "Presiona Enter para volver al menu..."
    }
}