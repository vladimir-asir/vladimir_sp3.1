#!/bin/bash

# Este script genera una copia de seguridad comprimida del directorio de usuario
# El archivo de copia se nombra según la semana actual del año para facilitar la diferenciación.

# 1. Obtiene el número de semana actual del año (00-53) y lo guarda en una variable.
NUM_SEMANA=$(date +%U)

# 2. Define el directorio base donde se guardarán las copias.
DIR_DESTINO="/bacvladimir"

# 3. Define el nombre del archivo de registro de las operaciones.
ARCHIVO_LOG="$DIR_DESTINO/registro_backups.log"

# 4. Define el nombre completo del archivo de copia comprimido (tar.gz).
# El nombre incluirá el prefijo, el número de semana y la extensión.
NOMBRE_BACKUP="$DIR_DESTINO/CopDifSem-$NUM_SEMANA.tar.gz"

# 5. Ejecuta la copia de seguridad: comprime y archiva el directorio /home.
# -c: Crear archivo
# -z: Comprimir con gzip
# -f: Usar el nombre de archivo especificado
tar -czf "$NOMBRE_BACKUP" /home

# 6. Registra el evento de la copia de seguridad en el archivo de log.
# La fecha y hora exactas se capturan al final de la ejecución.
echo "Backup Semanal (Semana $NUM_SEMANA) creado: $(date)" >> "$ARCHIVO_LOG"
