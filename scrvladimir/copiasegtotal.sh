#!/bin/bash

# Este script realiza una copia de seguridad COMPLETA y MENSUAL del directorio de usuario.
# El archivo de backup se nombra usando el mes y año actuales para identificarlo fácilmente.

# 1. Captura el mes y año actuales (ej: Nov2025) y lo guarda en una variable.
ID_MES_Y_ANIO=$(date +"%B%Y")

# 2. Define el directorio base donde se guardarán todas las copias de seguridad.
DIR_ALMACEN="/bacvladimir"

# 3. Define el nombre del archivo de registro para las copias.
ARCHIVO_REGISTRO="$DIR_ALMACEN/registro_backups.log"

# 4. Define el nombre completo del archivo de copia comprimido (tar.gz).
NOMBRE_ARCHIVO="$DIR_ALMACEN/BackupTotal-$ID_MES_Y_ANIO.tar.gz"

# 5. Ejecuta la copia de seguridad: comprime y archiva el directorio /home.
# -c: Crear archivo, -z: Comprimir con gzip, -f: Usar el nombre de archivo especificado
tar -czf "$NOMBRE_ARCHIVO" /home

# 6. Registra el evento de la copia de seguridad en el archivo de log, incluyendo la fecha y hora.
echo "Copia Total Mensual ($ID_MES_Y_ANIO) creada: $(date)" >> "$ARCHIVO_REGISTRO"
