# Este script filtra eventos de inicio de sesión exitosos (ID 4624) del log de Seguridad
param(
    # Variable para definir la fecha de comienzo de la búsqueda
    $FechaComienzo,
    # Variable para definir la fecha limite de la búsqueda
    $FechaLimite
)

Write-Host "--- Eventos de Inicio de Sesion Encontrados ---"

Get-EventLog -LogName Security -After $FechaComienzo -Before $FechaLimite |
Where-Object { 
    # Filtramos solo por eventos de inicio de sesión exitosos (Instance ID 4624)
    $_.InstanceId -eq 4624
} |
Where-Object {
    # Capturamos el nombre de usuario
    $NombreUsuario = $_.ReplacementStrings[5]
    
    # Excluimos cuentas de servicio, de sistema y otros usuarios internos
    $NombreUsuario -ne "SYSTEM" -and
    $NombreUsuario -ne "DWM-1" -and
    $NombreUsuario -ne "DWM-0" -and
    $NombreUsuario -ne "UMFD-1" -and
    $NombreUsuario -ne "UMFD-0" -and
    $NombreUsuario -ne "LOCAL SERVICE" -and
    $NombreUsuario -ne "NETWORK SERVICE"
} |
ForEach-Object {
    # Mostramos la fecha/hora del evento y el nombre de la cuenta que inició sesión
    Write-Host "Fecha: $($_.TimeGenerated) - Usuario: $($_.ReplacementStrings[5])"
}