#!/bin/bash
<<'com'
    Objetivo del script:
        - Añadir usuarios a uno o varios grupos de manera interactiva.
    ------------------------
    Otras buenas prácticas:
        - Usar variables en minúscula
        - Escribir los mensajes de los "echo" en inglés
        - Guardar los comandos dentro de la expresión '$()' en lugar de entre tildes (`)
        - Usar códigos de error (1, 2, 3...)
        - Usar variables booleanas para controlar los bucles
        - Añadir controles lo más restrictivos posibles para que el usuario no haga fallar al script.
com

# Como vamos a ejecutar comandos que requieren de privilegios root, comprobamos los permisos
if [ $(id -u) -ne 0 ] # Siempre comprobar los permisos buscando el id '0', ya que el usuario 'root' es el único que lo puede tener
then
    echo "This script must be executed with root privileges."
    exit 1 # Usar un código de error diferente para cada problema
else
    # Como necesitamos un usuario obligatoriamente, el número de parámetros debe de ser uno. (Podemos poner mínimo uno, ya que si se ponen más, solamente trabajaremos con el primero)
    if [ $# -ne 1 ] 
    then
        echo "This script needs one parameter: '$0 [parameter_1]'"
        exit 2
    else
        user_to_modify=$1 # Definir el primer parámetro como una nueva variable para una mejor comprensión dentro del script
        cat /etc/passwd | grep ^$user_to_modify > /dev/null 2>&1 # Ejecutar el comando para comprobar si el usuario existe.
        if [ $? -eq 1 ] # Comprobar el código de error del comando anterior. Si es '1' significa que ha fallado (el usuario no existe)
        then
            echo "The user '$user_to_modify' does not exists."
            exit 3
        else
            # Definir una variable booleana para controlar el bucle
            keep_running=true
            while $keep_running
            do
                read -p "Write the group you want to add '$1' to: " group
                cat /etc/group | grep ^$group > /dev/null 2>&1 # Lo mismo que al comprobar si el usuario existe.
                if [ $? -eq 1 ]
                then
                    echo "The group '$group' does not exists."
                else
                    usermod -aG $group $user_to_modify 2>> ./errors_$user_to_modify.log # Añadir el usuario al grupo
                fi
                # Definir otra variable para controlar el segundo bucle
                control=true
                while $control
                do
                    read -p "Do you want to add '$user_to_modify' to another group? (Y/N): " opt
                    # Usar un switch mejor ya que queremos que el usuario tenga respuestas limitadas.
                    # Añadimos también las minúsculas para facilitar el proceso al usuario
                    case "$opt" in
                        # Si el usuario elige "Sí", salimos del segundo bucle, pero no del primero.
                        "Y")
                            control=false
                        ;;
                        "y")
                            control=false
                        ;;
                        # Si el usuario elige "No", salimos de ambos bucles.
                        "N")
                            keep_running=false
                            control=false
                        ;;
                        "n")
                            keep_running=false
                            control=false
                        ;;
                        # Salida por defecto
                        *)
                            echo "Only 'Y' and 'N' are valid options."
                        ;;
                    esac
                done
            done
            # Creamos una variable para obtener el total de grupos secundarios del usuario.
            total_groups=$(cat /etc/group | grep $user_to_modify | grep -v ^$user_to_modify | wc -l)
            # El primer 'grep' devuelve las líneas en las que aparece el usuario
            # Como sabemos que las líneas que devuelve el primer 'grep' solamente contienen el grupo principal del usuario
            # y los grupos secundarios del usuario, filtramos inversamente con el segundo 'grep'.
            # En '/etc/group' el primer campo es el nombre del grupo, y el último la lista de usuarios que pertenecen al mismo.
            # Filtrando con 'grep -v ^$usuario' hacemos la búsqueda inversa de las líneas que comiencen con el nombre del usuario.
            # Esto solamente nos deja las líneas en las que el usuario aparece como miembro de un grupo, es decir: en el último campo del formato de '/etc/group' 
            # Con 'wc -l' contamos las líneas.
            echo -e "User addition to groups finished. \nThe user '$user_to_modify' is member of '$total_groups' groups."
            echo -e "This is the list of groups the user is member of: \n$(cat /etc/group | grep $user_to_modify | grep -v ^$user_to_modify | awk -F: {'print $1'})"
        fi
    fi
fi