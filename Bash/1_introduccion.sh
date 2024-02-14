#!/bin/bash
# José Daniel Fernández López

echo "##########################################################################"
echo "# Recuerda abrir este script con un editor de texto como 'nano' o 'vim'! #"
echo "##########################################################################"

<<'com'

    Como habrás visto ya en las dos primeras líneas, en bash usamos "#" para poner un comentario en una línea; aunque para bash, la primera línea, aunque empiece con un comentario, servirá para definir el intérprete de comandos. En nuestro caso siempre será "#!/bin/bash"; si fueses a usar Python, tendrías que poner "#!/usr/bin/python".

    Siguiendo con los comentarios, para hacer un bloque, usamos 2 signos de "<" junto con una palabra entre comillas simples para definir como cierre; en el caso de este bloque, he usado 'com'.

    Ahora, como buena práctica, después del intérprete de comandos normalmente ponemos quién o quiénes han hecho el script, y si además se modifica con regularidad, añade la fecha de la útlima modificación (aunque si trabajas con un repositorio de git, habrá un historial de los cambios)

com

# Primera parte: variables

# El uso de variables en bash es bastante sencillo. Podemos trabajar con cadenas de texto y números.
# Para definirlas, seguimos el formato: [nombre]=[valor]
# En este primer ejemplo, con texto, lo pondremos entre comillas dobles.
texto="Hello World!"
# Y para usarlas, las llamamos por su nombre acompañadas por el símbolo '$'
echo $texto
# Por ejemplo, si quisiéramos usar comillas dentro del texto que vamos a mostrar, tenemos estas opciones:
texto='Hello "World"!'
echo $texto
texto="Hello 'World'!"
echo $texto
# Aunque esto funcione con cadenas de texto, nos encontraremos problemas con el uso de las comillas si mezclamos el uso de comandos o variables junto con texto
user=$(whoami)
echo "Hola, $user"
echo 'Hola, $user'
# Si has ejecutado este script, verás que en el primer saludo aparecerá tu nombre de usuario, mientras que en el segundo aparece la variable como tal. Ten esto en cuenta de aquí en adelante para futuros scripts.

# Para trabajar con números, viene a ser prácticamente igual que con el texto
num1=2
num2=3
total=$((num1+num2)) # Para sumar variables que contienen números, deberemos de abrir '$(())' en la definición de la variable.
echo $total
# También podemos hacer la operación en una misma línea sin necesidad de usar otra variable:
echo "$((num2-num1))"
# Existe otro método para hacer estas operaciones, aunque en mi opinión, no es la que usaría normalmente
num3=4
num4=5
total2=`expr $num3 + $num4`
# O puedes usar: total2=$(expr $num3 + $num4)
echo $total2
echo "--------------------------------------------------------------------------------------------------------------"
# --------------------------------------------------------------------------------------------------------------
<<'com'

    Como es evidente, también querrás hacer que el usuario pueda introducir los valores que quiera para las variables.
    Vamos a aprovechar esto para también explicar el funcionamiento de los operadores aritméticos [+, -, *, /, %] creando una "calculadora".
    Debes de tener muy en cuenta que las operaciones en bash funcionan con números enteros; si usas decimales, tu código va a funcionar, pero los resultados serán erróneos y tendrás que usar otros comandos para hacer que lo que obtengas sea correcto.

    Los operadores en detalle:

    1. Suma (+) -> Suma dos números. [2+3=5]
    2. Resta (-) -> Resta dos números. [8-5=3]
    3. Multiplicación (*) -> Multiplica dos números. [2*4=8]
    4. División (/) -> Divide dos números. En caso de que ambos sean enteros, el resultado también lo será. [12/3=4]
    5. Módulo (%) -> Devuelve el resto de la división entera de dos números. [5%3=2]

    Estas son las operaciones sencillas, pero también existen otras variaciones:

    - Incremento (++) -> Aumenta en 1 el valor de la variable. [((num++))]
    - Decremento (--) -> Disminuye en 1 el valor de la variable. [((num--))]
    (En estos casos de incremento y decremento, la posición de los signos importa, ya que indica qué se hace primero: si trabajar con la variable, o sumar o restar)
    - Potencia (**) -> Eleva un número a la potencia de otro. [((num1**num2))]
        En este ejemplo de la potencia, si:
        num1=2
        num2=3
        total=$((num1**num2))
        # La salida del comando sería
        > 8
        # Que escrito en notación exponencial sería lo mismo que: 2^3
        # Dos elevado a tres
    - Asignación con operación (+=, -=, *=, /=, %=) -> Expresar de una forma más corta una de las operaciones.
        # Por ejemplo, partiendo de que 'num1=3', en lugar de expresar la suma así:
        total=$(num1+2)
        # Podemos hacer lo siguiente:
        num1+=2
        # Hacer esto nos ahorarría declarar una variable más. (A un nivel más bajo, esto significaría menos consumo de memoria, pero con lo que vamos a trabajar de momento, no es muy relevante)

com

# Ahora vamos a crear una "calculadora" en la que le vamos a pedir los dos números al usuario.
# Para leer un input por consola, usaremos el comando "read" con la flag "-p" para además mostrar un mensaje por pantalla
read -p "Introduce el valor del primer número: " num1
read -p "Introduce el valor del segundo número: " num2
echo "Suma -> $((num1+num2))"
echo "Resta -> $((num1-num2))"
echo "Multiplicación -> $((num1*num2))"
echo "División -> $((num1/num2))"
echo "Módulo -> $((num1%num2))"
echo "Incremento -> $((++num1))"
echo "Decremento -> $((--num1))"
echo "Potencia -> $((num1**num2))"
echo "Asignación de suma-> $((num1+=num2))"
echo "--------------------------------------------------------------------------------------------------------------"
# --------------------------------------------------------------------------------------------------------------

<<'com'

    En las variables también podemos guardar la salida resultante de un comando como "ls", por ejemplo.
    Para ello, usamos '$([comando])', donde dentro de los corchetes podemos meter los comandos de Linux que queramos, siempre y cuando estén correctamente escritos.

    Por ejemplo, si quisiéramos guardar en una variable la salida que nos devuelve actualizar los repositorios y paquetes de nuestro Debian/Ubuntu, ejecutaríamos lo siguiente:
        resultado_actualizacion=$(sudo apt update; sudo apt upgrade -y)
        echo $resultado_actualizacion > actualizacion.log
        # Aquí hemos usado la redirección, que ya lo veremos más adelante, pero lo importante es el uso del comando como contenido de la variable.

    Guardar la salida de los comandos dentro de variables nos facilitará mucho tareas administrativas a la hora de filtrar en directorios o ficheros.
    Un uso muy común de esto es a la hora de ver los registros de un servicio que se ha detenido y queremos buscar en ellos la palabra error.
    (Para estas tareas deberás de saber cómo usar los comandos 'cat', 'head', 'tail, 'grep', 'awk', 'IFS' y las 'pipes' [|], pero ya iremos entrando en detalle).

    Un ejemplo de este filtrado lo podemos usar en el archivo 'passwd', donde está toda la información de los usuarios del sistema.
com
user="root" # Definimos el usuario del que queremos saber la información
user_line=$(cat /etc/passwd | grep -i "$user") # Obtenemos el contenido del archivo 'passwd' y filtramos con el comando 'grep'
echo $user_line # Mostramos el resultado del comando
echo "--------------------------------------------------------------------------------------------------------------"
# --------------------------------------------------------------------------------------------------------------
