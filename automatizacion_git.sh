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

clear

linea
centrar "AUTOMATIZACIÓN GIT"
centrar "CENTRO DE CÓMPUTOS"
linea
echo

# Primero veremos el estado con git status, este comando muestra qué archivos fueron modificados o son nuevos

centrar "ESTADO ACTUAL DEL REPOSITORIO"
git status

echo
read -p "Presione ENTER para agregar los cambios..."

# Ahora agregamos los cambios con git add . (comando que agrega los archivos modificados y los nuevos)

clear

linea
centrar "AUTOMATIZACIÓN GIT"
centrar "AGREGAR CAMBIOS"
linea
echo

git add .

if [ $? -ne 0 ]
then

    echo
    centrar "ERROR AL EJECUTAR GIT ADD"

    read -p "Presione ENTER para continuar..."

    exit 1

fi


centrar "CAMBIOS AGREGADOS CORRECTAMENTE"

echo


# Ahora vemos los datos nuevamente para ver los cambios

git status


echo
read -p "Presione ENTER para crear el commit..."

# Luego creamos el commit para guardar el grandioso checkpoint

clear

linea
centrar "CREAR COMMIT"
centrar "AUTOMATIZACIÓN GIT"
linea
echo


# se pide al usuario el mensaje del commit

read -p "Ingrese el mensaje del commit: " mensaje

# Este if me parecio necesario explicarlo, basicamente si el mensaje está vacío da error, esto se ve con el parámetro -z

if [ -z "$mensaje" ]
then

    echo
    centrar "EL MENSAJE NO PUEDE ESTAR VACÍO"

    read -p "Presione ENTER para continuar..."

    exit 1

fi


git commit -m "$mensaje"

if [ $? -ne 0 ]
then

    echo
    centrar "ERROR AL CREAR EL COMMIT"

    read -p "Presione ENTER para continuar..."

    exit 1

fi


echo
centrar "COMMIT CREADO CORRECTAMENTE"


echo
read -p "Presione ENTER para subir los cambios a GitHub..."

# Ahora la parte para subir los datos con el comando git push hacia github

clear

linea
centrar "SUBIENDO CAMBIOS A GITHUB"
centrar "AUTOMATIZACIÓN GIT"
linea
echo

git push

if [ $? -eq 0 ]
then

    echo
    centrar "CAMBIOS SUBIDOS CORRECTAMENTE A GITHUB"

else

    echo
    centrar "ERROR AL SUBIR LOS CAMBIOS"
    centrar "VERIFIQUE LA CONEXIÓN CON GITHUB"

fi

# Por ultimo con git log -l mostramos solo el ultimo commit del historial de forma resumida (gracias al --oneline)

echo
linea

centrar "ÚLTIMO COMMIT"

linea

echo

git log -1 --oneline

echo
read -p "Presione ENTER para continuar..."
