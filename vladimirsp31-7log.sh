#!/bin/bash
# --- SCRIPT DE BUSQUEDA DE ERRORES EN REGISTROS DE SISTEMA ---

echo "Iniciando barrido de logs para detectar fallos..."

# Crear archivo de resultados, sobrescribiendo el anterior
echo "--- RESULTADOS DE ERRORES EN LOGS ---" > reporte_errores.txt

# Iterar sobre cada archivo y carpeta dentro del directorio principal de logs
for registro in /var/log/*
do
    # Comprobar si la entrada es un archivo de registro regular (no un directorio)
    if [ -f "$registro" ]
    then
        # Buscar las palabras 'error' o 'fail' en el archivo, sin mostrar la salida
        # La opcion -l (lowercase L) solo lista el nombre del archivo si encuentra coincidencias
        grep -l "error\|fail" "$registro" > /dev/null

        # Comprobar el código de salida de grep (0 significa que encontró algo)
        if [ $? -eq 0 ]
        then
            # Si se encuentra un error, agregar el nombre del archivo al reporte
            echo "=== Archivo con problemas: $registro ===" >> reporte_errores.txt

            # Buscar y copiar las lineas con error/fail al reporte
            grep -i "error\|fail" "$registro" >> reporte_errores.txt

            # Agregar una linea en blanco para separar la salida
            echo "" >> reporte_errores.txt
        fi
    fi
done

echo "Barrido completado. Revisa el archivo 'reporte_errores.txt'"
