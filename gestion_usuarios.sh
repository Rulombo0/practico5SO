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

while true
do
    clear

    linea
    centrar "GESTIÓN DE USUARIOS"
    centrar "CENTRO DE CÓMPUTOS"
    linea

    echo

    echo "1. Dar de alta a un usuario"
    echo "2. Crear un grupo"
    echo "3. Listar grupos existentes"
    echo "4. Asignar usuario a un grupo"
    echo "5. Volver al menú principal"

    echo

    linea

    read -p "Seleccione una opción: " opcion


    case $opcion in

        1)
            clear

            linea
            centrar "ALTA DE USUARIO"
            linea
            echo

          
            read -p "Ingrese el nombre del usuario: " usuario

            # id cumple la funcion de comprobar si el usuario ya existe

            if id "$usuario"
            then
                centrar "El usuario ya existe."

            else
                sudo useradd -m "$usuario"

                # $? contiene la  alida del comando anterior
                # 0 significa que el comando se ejecutó correctamentde

                if [ $? -eq 0 ]
                then
                    centrar "Usuario creado correctamente."
                else
                    centrar "No se pudo crear el usuario."
                fi
            fi

            echo
            read -p "Presione ENTER para continuar..."
            ;;

        2)
            clear

            linea
            centrar "CREAR GRUPO"
            linea
            echo

            read -p "Ingrese el nombre del grupo: " grupo

            # lo que haec getent group es comprobar si existe el grupo

            if getent group "$grupo"
            then
                centrar "El grupo ya existe."

            else

                sudo groupadd "$grupo"


                # Este if comprueba la creación del grupo

                if [ $? -eq 0 ]
                then
                    centrar "Grupo creado correctamente."
                else
                    centrar "No se pudo crear el grupo."
                fi
            fi

            echo
            read -p "Presione ENTER para continuar..."
            ;;

        3)
            clear

            linea
            centrar "GRUPOS EXISTENTES"
            linea
            echo

            # /etc/group es el directorio que contiene la  información sobre los grupos
            # cut -d: utiliza ":" como separador
            # -f1 muestra solamente el primer campo
            # Con esto solo se lista el nombre de los grupos

            cut -d: -f1 /etc/group

            echo
            read -p "Presione ENTER para continuar..."
            ;;

        4)
            clear

            linea
            centrar "ASIGNAR USUARIO A GRUPO"
            linea
            echo

            read -p "Ingrese el usuario: " usuario
            read -p "Ingrese el grupo: " grupo


            # Primero se comprueba si existe el usuarioç

            if id "$usuario"
            then

                # Después comprobamos si existe el grupo

                if getent group "$grupo"
                then
                    sudo usermod -aG "$grupo" "$usuario"


                    # Este if comprueba que haya salido todo bien

                    if [ $? -eq 0 ]
                    then
                        centrar "Usuario agregado al grupo correctamente."
                    else
                        centrar "No se pudo agregar el usuario."
                    fi

                else
                    centrar "El grupo no existe."
                fi

            else
                centrar "El usuario no existe."
            fi

            echo
            read -p "Presione ENTER para continuar..."
            ;;

        5)
            break
            ;;

        *)
            echo
            centrar "ERROR 404 (le erraste profe)"
            read -p "Presione ENTER para continuar..."
            ;;

    esac
done
