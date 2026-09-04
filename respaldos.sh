#!/bin/bash

# El ORIGEN es la carpeta a respaldar

ORIGEN="web"

# DESTINO es la carpeta donde se guardara el respaldo

DESTINO="respaldos"

# FECHA obtiene los datos del momento en el que se hizo el respaldo

FECHA=$(date +"%Y-%m-%d_%H-%M-%S")

# ARCHIVO indica el nombre final del archivo de respaldo

ARCHIVO="$DESTINO/web_$FECHA.tar.gz"

ANCHO=$(tput cols)

linea() {
    printf '%*s\n' "$ANCHO" '' | tr ' ' '_'
}

centrar() {
    local texto="$1"
    local longitud=${#texto}

    if [ "$longitud" -ge "$ANCHO" ]; then
        printf "%s\n" "$texto"
    else
        local espacios=$(( (ANCHO - longitud) / 2 ))
        printf "%*s%s\n" "$espacios" "" "$texto"
    fi
}


clear

linea
centrar "SISTEMA DE RESPALDOS"
centrar "CENTRO DE CÓMPUTOS"
linea

if [ ! -d "$ORIGEN" ]
then
    centrar "Error: la carpeta web no existe."
    read -p "Presione ENTER para continuar..."
    exit 1
fi

tar -czvf "$ARCHIVO" "$ORIGEN"

if [ $? -eq 0 ]
then
    echo
    centrar "Respaldo realizado correctamente."
    centrar "Fecha y hora: $FECHA"
    centrar "Archivo: $ARCHIVO"
else
    echo
    centrar "Error al realizar el respaldo"
fi

linea

read -p "Presione ENTER para continuar..."
