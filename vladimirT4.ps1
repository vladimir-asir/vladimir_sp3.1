# =================================================================
# SCRIPT DE ROTACION Y LIMPIEZA DE LOG DE SEGURIDAD
# =================================================================

# Definimos la ruta de destino para el backup y el nombre del archivo
$RutaBackup = "C:\LogBackups\"
$Fecha = Get-Date -Format "yyyyMMdd_HHmm"
$NombreArchivo = "Security_Backup_$Fecha.evt"
$RutaCompleta = $RutaBackup + $NombreArchivo

# Aseguramos que la carpeta de backups exista
if (-not (Test-Path $RutaBackup)) {
    New-Item -Path $RutaBackup -ItemType Directory | Out-Null
}

Write-Host "--- Tarea de Rotacion de Logs Iniciada ($(Get-Date)) ---"

try {
    # 1. Creamos la copia de seguridad del Log de Seguridad
    Write-Host "-> Creando backup del Log de Seguridad en: $RutaCompleta"
    Wevtutil.exe export-log Security $RutaCompleta /overwrite

    # 2. Limpiamos el Log de Seguridad para liberar espacio
    Write-Host "-> Limpiando el Log de Seguridad..."
    Clear-EventLog -LogName Security -ErrorAction Stop

    Write-Host "¡Log de Seguridad rotado y limpiado con exito!"
}
catch {
    Write-Host "ERROR: No se pudo completar la operacion."
    Write-Host "Detalle: $($_.Exception.Message)"
}

Write-Host "--- Tarea finalizada ---"
# =================================================================