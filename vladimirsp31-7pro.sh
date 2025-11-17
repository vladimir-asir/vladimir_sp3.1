#!/bin/bash

# Mensaje inicial del script
echo "==> DESINSTALADOR DE PAQUETES DE SISTEMA <== "

# Nombre del archivo que contiene la lista de programas a eliminar
ARCHIVO_LISTA="del_programas.txt"

# Comprobación de existencia del archivo con la lista
if [ ! -f "$ARCHIVO_LISTA" ]; then
    echo "ERROR: No se localiza el archivo $ARCHIVO_LISTA"
    echo "Por favor, crea el archivo y lista los paquetes a desinstalar."
    exit 1
fi

# Muestra los programas que se van a procesar
echo ""
echo "Programas listados para desinstalación:"
cat "$ARCHIVO_LISTA"
echo ""

# Pide confirmación al usuario antes de proceder
read -p "¿Confirmas la desinstalación de estos paquetes (s/n)? " CONFIRMACION

# Procesa la respuesta de confirmación
if [ "$CONFIRMACION" = "s" ] || [ "$CONFIRMACION" = "S" ]; then
    echo ""
    echo "Iniciando proceso de desinstalación de paquetes..."
    echo "Se requiere una contraseña de superusuario para 'sudo'."

    # Bucle para leer cada línea del archivo y ejecutar el comando de eliminación
    # La desinstalación es forzada (sin preguntar) y elimina archivos de configuración (--purge)
    while read NOMBRE_PAQUETE
    do
        # Se asegura de que la línea no esté vacía antes de intentar la eliminación
        if [ -n "$NOMBRE_PAQUETE" ]; then
            echo "-> Eliminando: $NOMBRE_PAQUETE"
            # Comando de eliminación real
            sudo apt remove --purge -y "$NOMBRE_PAQUETE"
        fi
    done < "$ARCHIVO_LISTA"

    # Mensaje final
    echo ""
    echo "✅ Desinstalación de paquetes finalizada."

else
    # Si la respuesta no fue 's' o 'S'
    echo ""
    echo "❌ Operación cancelada por el usuario."
fi
