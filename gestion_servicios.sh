#!/bin/bash

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

    # Primero pedimos el nombre del servicio

read -p "Ingrese el nombre del servicio: " servicio

while true
do
    clear

    linea
    centrar "GESTIÓN DE SERVICIOS"
    centrar "CENTRO DE CÓMPUTOS"
    linea

    echo

    # Ahora se muestra el servicio que actualmente estamos viendo

    centrar "Servicio actual: $servicio"

    echo

    echo "1. Ver estado"
    echo "2. Iniciar servicio"
    echo "3. Detener servicio"
    echo "4. Cambiar servicio"
    echo "5. Volver al menú principal"

    echo

    linea

    read -p "Seleccione una opción: " opcion


    case $opcion in

        1)
            clear

            linea
            centrar "ESTADO DEL SERVICIO"
            centrar "$servicio"
            linea
            echo

            # El parametro --no-pager evita que el resultado se abra en una ventana visual creo, no probé hacerlo sin eso

            systemctl status "$servicio" --no-pager

            echo
            read -p "Presione ENTER para continuar..."
            ;;

        2)

            sudo systemctl start "$servicio"

            # If de comprobación (no voy a hacer mas anotaciones para estos if)

            if [ $? -eq 0 ]
            then
                centrar "Servicio iniciado correctamente."
            else
                centrar "No se pudo iniciar el servicio."
            fi

            read -p "Presione ENTER para continuar..."
            ;;


        3)

            sudo systemctl stop "$servicio"

            if [ $? -eq 0 ]
            then
                centrar "Servicio detenido correctamente."
            else
                centrar "No se pudo detener el servicio."
            fi

            read -p "Presione ENTER para continuar..."
            ;;

        4)

            read -p "Ingrese el nuevo servicio: " servicio
            ;;

        5)
            break
            ;;

        *)
            echo
            centrar "ERROR 404 (hola profe le erraste de vuelta)"
            read -p "Presione ENTER para continuar..."
            ;;

    esac
done
