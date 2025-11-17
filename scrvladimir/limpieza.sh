#!/bin/bash

# Este script se encarga de eliminar archivos de backup antiguos para liberar espacio.

# 1. Define el directorio base donde se encuentran las copias de seguridad.
DIR_BACKUPS="/bacvladimir"

# 2. Define el nombre del archivo de registro donde se grabarán los eventos.
LOG_FILE="$DIR_BACKUPS/historial_mantenimiento.log"

# 3. Define el patrón (wildcard) de los archivos a eliminar.
# Esto asegura que solo se borren los archivos de las copias semanales (por ejemplo: CopDifSem-01.tar.gz)
PATRON_A_BORRAR="$DIR_BACKUPS/CopDifSem-*"

# Registra la fecha y hora de inicio de la tarea de limpieza.
echo "--- INICIO DE TAREA DE MANTENIMIENTO: $(date) ---" >> "$LOG_FILE"
echo "Buscando y eliminando archivos antiguos que coincidan con: $PATRON_A_BORRAR" >> "$LOG_FILE"

# 4. Ejecuta el comando de eliminación:
# rm -f: Elimina archivos de forma forzada (sin preguntar)
# ¡ADVERTENCIA!: Usar 'rm -f' con un wildcard puede ser peligroso si el patrón es incorrecto.
rm -f "$PATRON_A_BORRAR"

# Registra la finalización de la tarea.
echo "Proceso de limpieza de backups completado." >> "$LOG_FILE"
echo "---------------------------------------------------------" >> "$LOG_FILE"
