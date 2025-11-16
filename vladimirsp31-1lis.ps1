# Bucle principal del menú
while ($true) {
    Clear-Host # Limpia la pantalla para mostrar el menú de forma clara
    
    # Presentar el menú de acciones al usuario
    Write-Host "--- REVISOR DE EVENTOS ---"
    Write-Host "1. Mostrar ultimos eventos del sistema"
    Write-Host "2. Mostrar errores del ultimo mes"
    Write-Host "3. Mostrar warnings de aplicaciones de esta semana"
    Write-Host "4. Salir"
    Write-Host "----------------------------"

    # Capturar la entrada del teclado del usuario
    $seleccionUsuario = Read-Host "Elige una opcion (1, 2, 3 o 4)"

    # Evaluar la elección del usuario
    if ($seleccionUsuario -eq "1") {
        # Opción 1: Obtener los 10 eventos más recientes del log del Sistema
        Write-Host "Mostrando ultimos 10 eventos del sistema..."
        Get-EventLog -LogName System -Newest 10
    }
    elseif ($seleccionUsuario -eq "2") {
        # Opción 2: Filtrar errores del log del Sistema del último mes
        Write-Host "Buscando errores del ultimo mes..."
        $fechaInicio = (Get-Date).AddMonths(-1) # Define el punto de partida (hace 30 días)
        Get-EventLog -LogName System -EntryType Error -After $fechaInicio
    }
    elseif ($seleccionUsuario -eq "3") {
        # Opción 3: Filtrar advertencias del log de Aplicación de la última semana
        Write-Host "Buscando warnings de aplicaciones de esta semana..."
        $fechaInicio = (Get-Date).AddDays(-7) # Define el punto de partida (hace 7 días)
        Get-EventLog -LogName Application -EntryType Warning -After $fechaInicio
    }
    elseif ($seleccionUsuario -eq "4") {
        # Opción 4: Salir del script
        Write-Host "Saliendo..."
        break # Termina el bucle 'while'
    }
    else {
        # Bloque de control para entradas no válidas
        Write-Host "ERROR: Opcion incorrecta. Debes elegir 1, 2, 3 o 4."
    }

    # Pausa antes de volver a mostrar el menú
    Write-Host "" # Añade una línea en blanco
    Read-Host "Presiona Enter para volver al menu..."
}