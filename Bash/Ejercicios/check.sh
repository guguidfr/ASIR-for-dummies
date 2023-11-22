#!/bin/bash
# José Daniel Fernández López

<<'com'

    En linux, usando 'if', podemos verificar archivos, directorios y permisos.
    Esto nos puede resultar útil si tenemos una máquina de la que no conocemos el árbol de directorios,
    o queremos hacer que comprobar algo en el sistema sea maś cómodo que usar comandos.

    Para esto tenemos los llamados 'operadores sobre ficheros', y aunque hay muchos,
    voy a explicar los más usados:
        (Ten en cuenta que a no ser que especifique, el operador será sobre archivos, directorios o enlaces)
        (Para usar un nombre que englobe todo lo anterior, usaré 'elemento')

        - '-a': El elemento existe. Devuelve 'true' si se cumple.
        - '-d': El elemento existe y es un directorio. Devuelve 'true' si ambas condiciones se cumplen.
        - '-f': El elemento existe y es un fichero regular (no es un enlace a otra ubicación/archivo). Devuelve 'true' si ambas concidiones se cumplen
        - '-G': El grupo dueño del elemento coincide con el gid efectivo. Devuelve 'true' si el grupo dueño del elemento es el mismo que el del usuario que ha ejecutado el comando/script.
        - '-h', '-L': El elemento existe y es un enlace simbólico. Devuelve 'true' si ambas condiciones se cumplen (Un enlace simbólico es lo que llamaríamos "Acceso directo" en Windows)
        - '-O': El dueño del elemento coincide con el uid efectivo. Devuelve 'true' si el usuario dueño del elemento es el mismo que el del usuarip que ha ejecutado el comando/script
        - '-r': El elemento existe y tenemos permiso de lectura sobre el mismo. Devuelve 'true' si ambas condiciones se cumplen.
        - '-s': El elemento existe y está vacío. Devuelve 'true' si ambas condiciones se cumplen.
        - '-w': El elemento existe y tenemos permiso de escritura. Devuelve 'true' si ambas condiciones se cumplen.
        - '-x': El elemento existe y, si es un fichero tenemos permiso de ejecución, o de búsqueda si es un directorio.
        - '-z': Devuelve 'true' si la entrada está vacía.
    
    Estos operadores no necesitan de dos elementos a la hora de usarlos en las condiciones que definimos en un 'if'.
    Un ejemplo de su sintaxis sería la siguiente:
        (Donde donde la variable 'input' es un fichero o directorio que ha introducido el usuario)

        if [ -a "$input" ]
        then
            { código a ejecutar si lo que ha pasado el usuario existe }
        fi
    
    Esta sintaxis se repite para cualquiera de los operadores anteriores.

    ------------------------------------------------------------------------------------------------------------------------------------------

    Algo muy útil también saber introducir elementos en el script mediante el uso de "parámetros de entrada".
    Estos valores los introducimos directamente desde la llamada al script en nuestra terminal.
    Un ejemplo de introducción de 2 parámetros, con un script llamado "test.sh", sería así:
        usuario@Debian:~$ ./test.sh param1 param2
    
    A estos parámetros se les asigna automáticamente una variable dentro del script.
    Según cuál sea, de izquierda a derecha, tendrán un nombre u otro.
    Para el ejemplo anterior, la variable para el primer valor que hemos introducido, param1, sería: $1
    Y para el segundo valor, param2, sería: $2
    Si hubiera un tercer valor: $3
    Y un cuarto: $4

    Debes de tener en cuenta que, en esto de la informática, normalmente definimos el primer elemento de una cadena,
    una lista, o en general, un grupo de valores con el elemento número '0', pero para los parámetros de entrada en bash, 
    la variable '$0' contendrá siempre el propio nombre del script.
    Para nuestro ejemplo anterior, el valor de $0 sería: test.sh

    Junto a los parámetros también tenemos los "especiales":
        - '$*', '$@': Nos devuelve todos los parámetros a excepción de $0.
        - '$#': Nos devuelve el número de parámetros totales sin contar $0.
        - '$$': Nos devuelve el número de proceso del script. (Si buscamos ese número después de la ejecución, no lo encontraremos).
        - '$?': Nos devuelve el código de error de la última operación realizada.
    
    Esta última variable la usaremos mucho, ya que nos permitirá tomar decisiones dependiendo de si hay fallos con los comandos
    que ejecutemos, como por ejemplo, actualizar los repositorios y paquetes usando 'apt'.
    Un ejemplo para entenderlo fácilmente sería lo siguiente:
        apt update
        if [ $? -eq 0 ]
        then
            echo "Los repositorios se han actualizado correctamente"
        else
            echo "Ha habido un error al actualizar los repositorios"
        fi
    
    En este caso, si "apt update" se ejecuta correctamente, '$?' tendrá el valor '0' que, como hemos visto en las condicionales, 
    significa 'true', en este caso, que se ha ejecutado correctamente.
    Si hay algún problema con el comando, '$?' valdrá '1', lo que nos dirá que algo ha salido mal.

    Esta variable siempre tomará el valor de lo inmediatamente anterior que hayamos ejecutado a la comprobación de la misma.
    Es decir, que si ejecutamos dos comando seguidos y el primero va bien pero el segundo no, si comprobamos el valor
    de '$?', veremos que valdrá '1'.
    Ejemplo:
        apt update # Suponemos que sale bien
        cat ./archivo.txt # El archivo no existe, y sale mal
        echo $?

        Si ejecutamos esos comandos en orden (porque, sí, podemos hacer un 'echo $?' desde la terminal para ver si lo anterior que hemos
        ejecutado ha salido bien), veremos que la salida será un '1'.

com