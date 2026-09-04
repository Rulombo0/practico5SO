#!/bin/bash

# Hla profe estoy aprendiendo todo esto con chatgpt, esto es para detectar el ancho de la terminal
ANCHO=$(tput cols)

# Hice una funcion para hacer una linea completa, porque delimitando el ancho no me funcionó antes
linea() {
    printf '%*s\n' "$ANCHO" '' | tr ' ' '_'
}

# Y esta centra el texto porque no me gusta que no quede simetrico
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

while true
do
    clear

    linea
    centrar "BIENVENIDO AL PANEL DE ADMINISTRACIÓN"
    centrar "CENTRO DE CÓMPUTOS"
    linea

    echo
    echo "1. Gestión de usuarios"
    echo "2. Gestión de servicios"
    echo "3. Respaldos"
    echo "4. Automatización de Git"
    echo "5. Salir"
    echo

    linea

    read -p "Seleccione una opción: " opcion

    case $opcion in
        1)
            ./gestion_usuarios.sh
            ;;

        2)
            ./gestion_servicios.sh
            ;;

        3)
            ./respaldos.sh
            ;;

        4)
            ./automatizacion_git.sh
            ;;

        5)
            clear
            centrar "Saliendo del sistema, gracias profe!"
            echo
            break
            ;;

        *)
            echo
            centrar "ERROR 404 (que no existe lo que quisiste poner profe)"
            read -p "Presione ENTER para continuar..."
            ;;
    esac
done
