#!/bin/bash
# José Daniel Fernández López

<<'com'

    Una manera sencilla de entender cómo funcionan los comandos 'cat', 'head', 'tail, 'grep', 'awk', y las 'pipes' [|] es usando el archivo 'passwd'.
    Ahora, te explicaré el funcionamiento de estos:
    - 'cat' -> Muestra el contenido de un archivo, da igual su extensión. Ten en cuenta que si el contenido no es texto plano, te encontrarás con un montón de símbolos y cosas sin sentido.
    - 'head' -> Muestra las primeras líneas de un archivo. Por defecto son las 10 primeras líneas, pero podemos usar la 'flag' '-n' junto con un número para ver una cantidad concreta que queramos. Se suele usar junto con 'cat' y una 'pipe' (|).
    - 'tail' -> Muestra las últimas líneas de un archivo. Por defecto son las 10 últimas líneas, pero podemos usar la 'flag' '-n' junto con un número para ver una cantidad concreta que queramos. Se suele usar junto con 'cat' y una 'pipe' (|).
    - 'grep' -> Nos permite buscar patrones dentro de un texto. Se suele usar tras una 'pipe' (|), permitiéndonos así usarlo junto otros comandos o buscar dentro de directorios. Una 'flag' muy útil es '-i', que hará la búsqueda sin diferenciar entre mayúsculas y minúsculas; será un filtrado 'case INsensitive'.
    - 'awk' -> La mejor herramienta para obtener datos de un archivo en el que los campos van separados por un elemento. El mejor ejemplo es con un archivo '.csv' (Comma Separated Values), donde cada campo en cada línea va separado por una coma (,) o un punto y coma (;). 'awk' nos permitirá elegir de qué 'columna' tomar los datos.
    - pipes '|' -> Nos permiten redirigir la salida de un comando para que sea la entrada del siguiente. En el siguiente ejemplo usando 'cowsay' lo entenderás.

        El comando 'cowsay' en Linux nos permite tener una vaca en arte ASCII con la que podemos hacer que diga lo que queramos. Por ejemplo, si uso el comando 'cowsay "Hello World!"', obtendré lo siguiente:
         ______________
        < Hello World! >
        --------------
                \   ^__^
                 \  (oo)\_______
                    (__)\       )\/\
                        ||----w |
                        ||     ||

        En este caso, la entrada para el comando 'cowsay' ha sido "Hello World!".

        Ahora, supongamos que tenemos un archivo llamado 'saludo.txt' que contiene únicamente una línea que dice: "¡Este mensaje es desde un archivo!".
        Si hacemos un 'cat' de este archivo, veremos su contenido en la consola.
        Pero ¿y si queremos que sea la vaca quién diga el contenido? Pues hacemos un 'cat' de nuestro archivo, y se lo pasamos a la vaca con el comando 'cowsay'.
        Lo que ejecutaríamos en total sería: cat saludo.txt | cowsay

        guguidfr@guguidfr-PC:~$ cat saludo.txt | cowsay
        ____________________________________
        < ¡Este mensaje es desde un archivo! >
        ------------------------------------
                \   ^__^
                 \  (oo)\_______
                    (__)\       )\/\
                        ||----w |
                        ||     ||

        Con esto, ya habremos hecho que la vaca diga lo que contiene el archivo.
        Ten en cuenta que 'cowsay' no viene por defecto en todas las distribuciones de Linux, por lo que tendrás que instalar el paquete usando 'apt install'.

        Y ahora que ya sabes cómo funcionan las principales de herramienta de filtrado, vamos con los ejemplos.
com

# Segunda parte: manejo y filtrado de texto

# Para ejemplificar 'cat', vamos a empezar por mostrar el archivo 'passwd'. La ubicación es: /etc/passwd
# Esto simplemente nos muestra el contenido del archivo
cat /etc/passwd
echo "--------------------------------------------------------------------------------------------------------------"
# --------------------------------------------------------------------------------------------------------------

# Ahora vamos a usar 'cat' con 'head' y con 'tail' usando 'pipes'
cat /etc/passwd | head # Mostramos las 10 primeras líneas
echo "--------------------------------------------------------------------------------------------------------------"
cat /etc/passwd | tail # Mostramos las 10 últimas líneas

# Recuerda que con 'head' y 'tail' puedes usar '-n' junto con un número para concretar cuántas líneas quieres ver.
echo "--------------------------------------------------------------------------------------------------------------"
# --------------------------------------------------------------------------------------------------------------

# Para entender 'grep', vamos a pedir al usuario un nombre, y filtraremos en el archivo 'passwd' para buscar coincidencias.
read -p "Introduce un nombre de usuario: " username
results=$(cat /etc/passwd | grep -i "$username") # Guardamos en una variable el resultado de la búsqueda en el archivo. La flag '-i' hace que 'grep' no diferencie entre mayúsculas y minúsculas.
echo "Las coincidencias de la búsqueda son las siguientes: "
echo "$results"
# Como estamos haciendo algo sencillo para entender el funcionamiento de 'grep' no he hecho control de errores.
# Lo correcto aquí sería comprobar que el usuario no deja en blanco la variable 'username' y luego comprobar si ha habido coincidencias en la búsqueda en el archivo 'passwd'.
# Ya hablaremos del control de errores más adelante.
echo "--------------------------------------------------------------------------------------------------------------"
# --------------------------------------------------------------------------------------------------------------

<<'com'

    El comando 'awk' es muy potente a la hora de hacer búsquedas en archivos que contienen separadores entre los valores.
    Cuando empezamos a usarlo puede ser algo difícil de entender cómo funciona, pero intentaré dejar claro lo más básico.

    'awk' siempre necesita la 'flag' '-F', que nos sirve para indicar el separador del archivo. En el caso de un '.csv', los campos van separados normalmente con comas (,)
    o de vez en cuando con punto y coma (;).
    Entonces, para decirle a 'awk' que el separador que vamos a usar es la coma, lo haríamos así: awk -F,

    Debes de tener en cuenta que el separador va seguido a la 'F' de la flag; no dejamos ningún espacio, ni tabulador, ni lo ponemos entre comillas.

    Para nuestros ejemplos, en los que estamos usando el archivo 'passwd', habrás podido ver que los valores van separados por dos puntos (:),
    así que usaremos el comando 'awk' de la siguiente manera: awk -F:

    Ahora que ya sabemos cómo decirle a 'awk' con qué están separados los valores, tenemos que decirle qué queremos hacer con ellos.
    Como principalmente lo vamos a usar para mostrar campos concretos, lo vamos a usar con la función 'print'.
    En este caso, 'print' es una función de 'awk'.
    Para usar 'print' necesitaremos abrir comillas simples ('') y dentro de estas unas llaves ({}).
    El comando, por ahora, sería así: awk -F: '{print}'

    Para este ejemplo, vamos a sacar del archivo 'passwd' a todos los usuarios.
    Si revisas el archivo, verás que los nombres de los usuarios son el primer valor en cada línea.
    Esto significa que para 'awk' son el campo '$1'. Si quisiéramos sacar el segundo campo, usaremos '$2'.
    Podemos mostrar en pantalla varios campos seguidos, basta con poner los números correspondientes separados con un espacio.

    Sabiendo esto, el resultado del comando 'awk' se nos queda en: awk -F. '{print $1}'
    Y como 'awk' necesita una entrada de texto, le pasamos el archivo 'passwd' con un 'cat' y una 'pipe': cat /etc/passwd | awk -F: '{print $1}'

    ----------------------------------------------------------------------------------------------------------------------------------------------

    Muchas veces no necesitamos obtener el valor de un campo; simplemente queremos contar cuántos hay.
    Para contar líneas, usaremos el comando 'wc' (de 'Word Count' en inglés).
    Por ahora nos bastará con saber que la 'flag' '-l' nos permitirá contar el número de líneas.

    Entonces, si quieremos contar cuántos usuarios hay en total en el archivo 'passwd', nuestro comando será el siguiente:
    cat /etc/passwd | awk -F: '{print $1}' | wc -l

    Si quieres saber más de 'wc', puedes consultar su manual o visitar esta web: https://www.geeksforgeeks.org/wc-command-linux-examples/

com

# Y para ver cómo funcionan 'awk' y 'wc', lo siguiente nos mostrará los usuarios del sistema y nos dirá cuántos son en total
totalUsers=$(cat /etc/passwd | awk -F: '{print $1}' | wc -l)
userNames=$(cat /etc/passwd | awk -F: '{print $1}')
echo "Se han encontrado $totalUsers usuarios:"
echo $userNames
