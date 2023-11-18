#!/bin/bash
# José Daniel Fernández López

<<'com'

    El enunciado de este ejercicio es el siguiente:
    "Haz un script de manera que cada vez que pases un fichero, compruebe qué permisos tiene una vez que hayas verificado si existe. La ejecución terminará cuando el usuario quiera salir."

    Una de las condiciones para este ejercicio es usar un bucle "while", y como además tenemos que preguntarle al usuario por un archivo, y si quiere salir, usaremos también un menú sencillo mediante "if"s anidados.

com

# Ya que no vamos a anidar bucles y vamos a comprobar pocas cosas, haremos un bucle infinito sencillo del que saldremos con "exit" con el código "0"
# Los códigos de error en linux nos sirven para saber qué ha pasado. Normalmente el "0" significa que le programa se ha detenido sin problemas, mientras que cualquiera mayor o igual que "1" nos indicará que algo ha ido mal

while true # Poner un "while true" es la manera más fácil de empezar un bucle, pero no podremos hacer control de salida usando variables; tendremos que usar "exit" o "break". Intenta evitar el uso de "break", ya que significa una detención forzosa del programa/script.
do

    # A partir de aquí, estamos dentro del bucle, lo que significará que se repetirá todo en orden hasta que salgamos del bucle o detengamos el script.
    # Lo que nos pide el enunciado, es que comprobemos permisos de un fichero, y le preguntemos al usuario si quiere salir, así que empezaremos con esa pregunta.

    read -p "Introduce 'S' si quieres comprobar los permisos de un fichero. Introduce 'N' si quieres salir del programa. [S/N]: " option # Hacemos un "read" para que el usuario nos diga lo que quiere hacer a continuación

    # Como tenemos dos opciones válidas, "Sí" o "No", tendremos que comprobar si el usuario ha introducido alguno de esos.

    # En el caso del "Sí", pondremos las cosas fáciles comprobado la "s" minúscula y la "S" mayúscula con la primera condicional usando un "OR" como operador lógico para las dos condiciones.
    # En bash, los operadores "AND", "OR" y "NOT" funcionan exactamente igual que una puerta lógica. Esto lo deberías de haber visto en "Fundamentos de Hardware".
    if [ "$option" == "s" ] || [ "$option" == "S" ] # En este primer caso, nuestro operador "OR" son las dobles "pipes" (||). Recuerda poner los espacios correctamente, o el "if" no funcionará.
    then

        # Si el programa ha llegado aquí es porque el usuario ha elegido "s" o "S", así que le vamos a pedir con otro "read" que nos diga dónde está el archivo.
        read -p "Introduce el nombre del archivo, junto con su extensión, del que quieras comprobar los permisos. Si está en una ubicación diferente al directorio actual, introduce su ruta relativa u absoluta: " file
        # Como puede ser que el usuario introduzca algo que no existe, para que obtengamos un error con el "ls" que tendremos que hacer, vamos a comprobar si lo que nos ha pasado existe de verdad
        if [ -e "$file" ] # Con "-e" comprobamos que algo existe (ya sea un directorio, un arhivo .txt, un archivo comprimido o un enlace simbólico); con "-f" verificamos si es un fichero (de "file" en inglés) y con "-d" comprobamos si es una carpeta (de "directory" en inglés).
        then

            # Si llegamos aquí es porque lo que ha pasado el usuario existe, así que podemos mostrar los permisos con un "ls -l"
            ls -l "$file"

        else

            # Si estamos aquí es porque el "-e" del "if" ha fallado y lo que ha pasado el usuario no existe en el sistema, así que se lo decimos en un mensaje
            echo "El fichero que has pasado no existe en el sistema"

        fi

    # AQUÍ ESTAMOS EN UN PUNTO MUY IMPORTANTE
    # Como verás justo encima, está el cierre del "if" con el "fi", lo que quiere decir que, aquí "fuera", volvemos a estar en el primer "if"
    # Pero también podrás ver que justo debajo hay un "elif", que es donde declaramos otra condición del "if", lo que quiere decir que hemos terminado, y como estamos en un bucle...
    # ... volveremos al principio y se ejecutará todo en el mismo orden de antes.

    # Si te cuesta ver dónde estamos, fíjate bien en la indentación y el anidamiento de las funciones.
    # La apertura del bucle "while" en este caso está "más a la izquierda", el primer "if" está un poco más a la derecha, y el "if" del que acabamos de salir lo está un poco más.
    # Esto quiere decir que, por ejemplo, si estuvieramos metiendo las muñecas de una "Matrioshka", de muñeca más grande a más pequeña estarían en el orden:
    # while > if 1 > if 2

    # Y para que lo veas aún más fácil, si usas Visual Studio Code o un IDE (Integrated Development Environment) similar, verás que las etiquetas de apertura y cierre del "while" y los "if" están conectadas.
    # Además, en Vistual Studio Code existe una extensión que se llama "Rainbow Indent" que te permite ver los niveles de indentación/anidamiento de diferentes colores.
    # Pruébalo: VSCode está disponible para Windows, Mac y Linux.

    elif [ "$option" == "n" ] || [ "$option" == "N" ] # Esta es la segunda opción de la pregunta que le hacemos el usuario, y es lo mismo que con la primera respuesta, pero en este caso con "n" y "N".
    then

        # Si llegamos aquí es porque el usuario ha decidio salir del programa
        exit 0 # Salimos con código "0" porque no ha habido ningún problema

    else # Esta es la que se llama "salida por defecto" del "if".

        # La salida por defecto es la que se ejecuta en caso de que no se cumpla niguna de las condiciones definidas en el "if" ni en los "elif" anteriores.
        # Como este "else" es del primer "if" de dentro del bucle, solamente ocurrirá cuando el usuario introduzca algo diferente a "s"/"S" o "n"/"N".
        # Recuerda que la salida por defecto es completamente opcional.

        echo "Has introducido algo no válido"
    fi
done
