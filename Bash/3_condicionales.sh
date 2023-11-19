#!/bin/bash
# José Daniel Fernández López

<<'com'

    En bash, las condicionales las usaremos mucho. Ya sea para el control de errores, tomar decisiones o manejar archivos y directorios.
    Lo primero que debes de saber es cómo escriben; para ello, mezclaré la sintaxis de bash con psudocódigo.
        (El pseudocódigo es lo que podríamos decir que es 'código inventado'; es decir, que escribimos como queremos para que sea inteligible por el lenguaje humano.)
        (Todo lo que sea pseudocódigo lo pondré entre llaves ({}) en los ejemplos)

    Las condicionales se inician con la función 'if', y siempre llevan alguna condición:

        if [ {condición} ]
        then
            {comandos que se ejecutan si la condición anterior se cumple}
        fi

    Este primer ejemplo es un 'if' muy básico:
        - su apertura con la condición (done pone 'if' seguido de los corchetes)
        - lo que hay que hacer en caso de que la condición se cumpla (lo indentado después de la palabra 'then')
        - el cierre de la condicional (donde pone 'fi')

    Debes de saber que para una condicional, lo anterior mencionado es lo mínimo obligatorio para que funcione.

    Antes de entrar en más detalles y en las modificaciones y variaciones de un 'if', debes de saber que es buena práctica anidar con una entrada de tabulador
    lo que hay que hacer si se cumple una condición.
    Esto de anidar lo puedes comprobar donde he puesto en el primer ejemplo "comandos que se ejecutan si la condición anterior se cumple".
    Fíjate que están más a la derecha que donde están el 'if' y el 'then'; esto se llama 'indentación', y nos sirve para dejar claro de
    manera muy visual que todo lo que escribamos a esa 'altura' estará dentro del 'then'.

    Esta indentación no es obligatoria, pero usarla nos permite identificar rápidamente la estructura que hemos seguido.
    Puedes ver la anidación y la indentación como una "Matrioshka".

    También debes saber que hay dos maneras diferentes de crear un 'if', aunque el primer ejemplo que he puesto es el que más me gusta y el que siempre uso.
    La otra manera de hacer un 'if' es la siguiente:

        if [ {condición} ]; then
            {comandos que se ejecutan si la condición anterior se cumple}
        fi

    --------------------------------------------------------------------------------------------------------------------------------------------------------------

    Ahora que sabes cómo se crea un 'if' sencillo, vamos a ver 'elif' y 'else'.
    Una condicional con estos dos nuevos elementos sería la siguiente:

        if [ {condición 1} ]
        then
            {comandos que se ejecutan si la condición 1 se cumple}
        elif [ {condición 2} ]
        then
            {comandos que se ejecutan si la condición 2 se cumple}
        else
            {comandos que se ejecutan si ninguna de las condiciones se cumplen}
        fi

    En este ejemplo tenemos un 'elif' y un 'else'.
        - 'elif' -> Lo usamos para definir otra condición. Podemos poner todos los que queramos.
        - 'else' -> Lo usamos para definir la llamada "salida por defecto". Esta "salida por defecto" es lo que se ejecutará si ninguna de las condiciones que hemos definido se cumple. Solamente podemos poner uno en una condicional, siempre va al final, y no es obligatorio ponerlo.

    Conociendo todos los elementos principales para las condicionales, debes de saber cómo se comprueban las condiciones que definimos.

    Bash es lo que llamamos un "lenguaje secuencial", ya que lo que escribimos en el código se ejecuta en orden; de la primera línea a la última.
    Esto significa que las condiciones que definamos se comprobarán de la primera, donde ponemos nuestro 'if', a la última, pasando por los siguientes 'elif' y el 'else' hasta encontrar el 'fi', que es el cierre.

    Cada vez que nuestro intérprete de comandos, bash, se encuentre con una condición, comprobará si se cumple; lo que en programación llamamos "comprobar si es 'true'".
    En inglés, 'true' significa 'verdad' o 'verdadero', lo que viene a ser para las condicionales, "que se cumple".

    Entonces, si una condición se cumple, bash entrará lo que esté anidado en el 'then' que hayamos definido tras la condición.
    Usando el ejemplo anterior, en el que tenemos 2 condiciones y la salida por defecto, debes de saber que:
        - Si se cumple la condición 1, se ejecutará lo que haya en el primer 'then' y no se comprobará la condición 2 ni se ejecutará la salida por defecto.
        - Si no se cumple la condición 1, se comprueba la 2; si esta se cumple, se ejecuta lo que haya en el segundo 'then' y no se ejecutará la salida por defecto.
        - Si ni la condición 1 ni 2 se cumplen, automáticamente se busca el 'else', y se ejecutará lo que tenga anidado: la salida por defecto.
        (En caso de que no hayamos definido un else, no se ejecutará nada)

    Con esto se explica el funcionamiento de las condicionales en bash:
        - Se comprueban por orden de aparición, de arriba a abajo.
        - Si la condición que se esté comprobando se cumple, se ejecuta "lo que diga su 'then' correspondiente"
        - Si la condición que se esté comprobando no se cumple, se pasa a comprobar la siguiente.
        - Si se han comprobado todas las condiciones y ninguna se cumple, se pasa al 'else' y se ejecuta la salida por defecto.
        - Si se han comprobado todas las condiciones, ninguna se cumple y no hay 'else', no hacemos nada en la condicional, y se sigue ejecutando lo que haya despues del cierre del 'fi'

    --------------------------------------------------------------------------------------------------------------------------------------------------------------

    Ya sabemos cómo se escriben las condicionales y cómo funciona la comprobación de las condiciones (qué redundante todo esto).
    Ahora veremos lo que se llaman "operadores lógicos", que nos sirven para definir las condiciones.

    Hay varios tipos de operadores lógicos, pero empezaremos por las más fáciles: aritméticas.
    (Si conoces Batch, te resultarán familiares.)
        - '-eq' -> Del inglés 'equals'. Lo usamos para comprobar si dos números son iguales: 'if [ 2 -eq 3 ]', o con variables, 'if [ $num1 -eq $num2 ]'
        - '-gt' -> Del inglés 'greater than'. Lo usamos para comprobar si un número es mayor que otro: 'if [ 4 -gt 2 ]', o con variables, 'if [ $num1 -gt $num2 ]'
        - '-lt' -> Del inglés 'less than'. Lo usamos para comprobar si un número es menor que otro: 'if [ 2 -lt 7 ]', o con variables, 'if [ $num1 -lt $num2 ]'
        - '-ge' -> Del inglés 'greater or equals'. Lo usamos para comprobar si un número es mayor o igual que otro: 'if [ 8 -ge 5 ]', o con variables, 'if [ $num1 -ge $num2 ]'
        - '-le' -> Del inglés 'less or equals'. Lo usamos para comprobar si un número es menor o igual que otro: 'if [ 4 -le 2 ]', o con variables, 'if [ $num1 -le $num2 ]'

    Lo más lógico para nosotros hubiera sido usar los operadores matemáticos que ya conocemos como: '=', '>', '<', '>=', '<='; pero su uso está reservado para las cadenas de texto.
    Para texto tenemos las comparaciones léxicográficas (ya sé que es una palabra feísima):
    - '==' -> Lo usamos para comprobar si dos cadenas de texto son iguales: 'if [ "$texto" == "almendra" ]'
    - '!=' -> Lo usamos para comprobar si dos cadenas son diferentes: 'if [ "$texto" != "almendra" ]'
    - '>' -> Lo usamos para comprobar si una cadena de texto es lexicográficamente mayor que otra: 'if [[ "$texto1" > "$texto2" ]]'
    - '<' -> Lo usamos para comprobar si una cadena de texto es lexicográficamente menor que otra: 'if [[ "$texto1" < "$texto2" ]]'
        (Para '<' y '>' usamos doble corchete ya que estos símbolos son lo que llamamos "caracteres reservados del sistema")
        (La comparación lexicográfica se hace a nivel ASCII; teniendo en cuenta el valor, posición y orden de los caracteres de las cadenas de texto.)
        (Échale un ojo a la tabla ASCII y haz pruebas si quieres hacer comparaciones, ya que en estos apuntes no entraremos en ellos.)

    --------------------------------------------------------------------------------------------------------------------------------------------------------------

    Por último tenemos lo que conocemos en el mundo del hardware y la electrónica como "puertas lógicas": 'OR', 'AND', 'NOT'.
    Antes de explicarlas, vamos a repasar cómo funcionan las puertas lógicas y cómo interpreta un ordenador que algo se cumple o no.

    Como ya sabrás, a muy bajo nivel nuestro ordenador trabaja con bits, que pueden solamente tener 2 posibles valores: '1' o '0'. Esto es lo que conocemos como "sistema binario".
    Pues, para las puertas lógicas pasa lo mismo, trabajan con '1' y 0'.
    Para estas puertas un '1' significa "verdad", "verdadero" o "que se cumple",
    y un '0' significa "falso" o "que no se cumple".

    Antes ya expliqué que para los 'if' ejecutamos lo "asignado" o "anidado" a los 'then' si la condición que definimos devuelve un 'true', es decir, un '1'.
        (Hay algunos sistemas y lenguajes de programación en los que esto es al contrario: '1' es 'false' y '0' es 'true'. Es similar a los códigos de error en bash; ya los veremos.)
    Pues las puertas lógicas nos permiten modificar el resultado final teniendo DOS condiciones.

    Las puertas lógicas reciben lo que llamamos como "entradas" y solamente devuelven una "salida". Esta "salida" dependerá de "lo que entre" y de la puerta con la que estemos tratando:
    - "AND" -> Se representa con un doble signo "et" (&&) (en inglés se le llama "ampersand"). En inglés es "Y", y funciona de la siguiente manera:
        - Si de entrada recibe dos 'true' (dos '1'), nos devolverá un 'true'.
        - Si de entrada recibe dos 'false' (dos '0'), nos devolverá un 'false'.
        - Si recibe un 'true' (un '1') y un 'false' (un '0'), nos devolverá un 'false'.
        Su funcionamento se describe como: "Devolverá 'true' siempre y cuando ambas entradas sean 'true'"

    - "OR" -> Se representa con una doble 'pipe' (||). En inglés es "O", y funciona de la siguiente manera:
        - Si de entrada recibe dos 'true' (dos '1'), nos devolverá un 'true'.
        - Si de entrada recibe dos 'false' (dos '0'), nos devolverá un 'false'.
        - Si recibe un 'true' (un '1') y un 'false' (un '0'), nos devolverá un 'true'.
        Su funcionamento se describe como: "Devolverá 'true' siempre que alguna de las entradas sea 'true'"

    - "NOT" -> Se representa con el símbolo del cierre de exclamación (!). Es la única puerta que solamente recibe una entrada. En inglés es "NO", y funciona de la siguiente manera:
        - Si recibe un 'true' (un '1'), devuelve un 'false' (un '0').
        - Si recibe un 'false' (un '0'), devuelve un 'true' (un '1').
        Su funcionamiento se describe como: "Devuelve lo opuesto de lo que entra"

    Las puertas lógicas las usamos para poner dos condiciones en una sola línea, y tienen su propia sintaxis.
    Primero veremos los ejemplos de sintaxis para las tres puertas y después comprobaremos los resultados.

    - "AND":
        - Primera forma: 'if [ {condición 1} ] && [ {condición 2} ]'
        - Segunda forma: 'if [[ {condición 1} && {condición 2} ]]'

    - "OR":
        - Primera forma: 'if [ {condición 1} ] || [ {condición 2} ]'
        - Segunda forma: 'if [[ {condición 1} || {condición 2} ]]'

    - "NOT": Se usa con una sola condición, pero la usamos para ejecutar lo asignado en el 'then' cuando la condición devuelve 'false' en lugar de 'true'
        - 'if ! [ {condición} ]'

    Salidas de las puertas lógicas:
    - "AND" -> 'if [[ 4 -gt 2 && "almendra" != "pistacho" ]]': la salida es 'true' porque ambas condiciones se cumplen: 4 es mayor que 2, y "almendra" es diferente de "pistacho".
            -> 'if [[ 1 -le 0 && "hola" == "hola" ]]': la salida es 'false' porque 1 no es menor o igual que 0.

    - "OR" -> 'if [[ 6 -eq 2 || "casa" != "manzana" ]]': la salida es 'true' porque aunque la primera condición es 'false', la segunda sí se cumple.
           -> 'if [[ 10 -le 7 || "zapato" == "gorra" ]]': la salida es 'false' porque ninguna de las condiciones se cumple.

    - "NOT" -> 'if ! [ 1 -ge 2 ]': el resultado final es 'true', ya que la condición es 'false'.
            -> 'if ! [ 0 -eq 0 ]': el resultado final es 'false', ya que la condición es  'true'.

    --------------------------------------------------------------------------------------------------------------------------------------------------------------

    Y ahora que conoces el funcionamiento básico, vamos a hacer algunos ejemplos.
com

# Como primer ejercicio, vamos a pedirle al usuario un número y vamos a comprobar si es positivo, negativo o 0

read -p "Introduce cualquier número: " num # Pedimos una entrada al usuario

if [ $num -eq 0 ] # Comprobamos si lo que ha introducido el usuario es 0
then
    echo "El número es cero"

elif [ $num -lt 0 ] # Si no es cero, comprobamos si es menor que cero, es decir, si es negativo
then
    echo "El número es negativo"

elif [ $num -gt 0 ] # Si no es negativo, puede que sea positivo o que el usuario no haya introducido un número.
then
    # Si es un número positivo, se mostrará este mensaje
    echo "El número es positivo"
fi

# Como este es un ejemplo sencillo, no hemos hecho control de entrada del usuario.
# Esto significa que si en lugar de introducir un número metemos un caracter especial o una letra, el script mostrará un error
echo "--------------------------------------------------------------------------------------------------------------"
# --------------------------------------------------------------------------------------------------------------

# Vamos a ver también la comparación de texto.
# Pedimos a un usuario que escriba un país de Europa:
read -p "Dime un país de Europa: " place
# Y vamos a comprobar si es alguno de los países que conozco:
if [ "$place" == "España" ]
then
    echo "¡Genial!¡Yo vivo en España!"
elif [ "$place" == "Alemania" ]
then
    echo "¡Qué bien!¡Yo sé hablar alemán!"
elif [ "$place" == "Francia" ]
then
    echo "¿Sabías que el croissant no es francés sino turco?"
else
    echo "O no he entendido qué país me has dicho, o no lo conozco"
fi
# Debes de tener en cuenta que las condiciones con texto son lexicográficas, por lo que se hacen usando el código ASCII.
# Esto básicamente significa que las condiciones son "case sensitive", es decir, que diferencian mayúsculas y minúsculas.
# Si el usuario introduce "españa" en lugar de "España", no se ejecutará la primera condición.
echo "--------------------------------------------------------------------------------------------------------------"
# --------------------------------------------------------------------------------------------------------------

# Ahora solamente nos quedan por ver las puertas lógicas.
# Vamos a hacer un ejemplo que tenga en cuenta nuestra nota nota del último examen y nuestra edad.
read -p "Introduce la nota de tu último examen [0-10]: " test
read -p "Introduce tu edad: " age
# Según nuestra edad y nota, sabremos si podemos salir y si podemos tomar alcohol

# Primera condición:
# Si hemos sacado un 10 y somos mayores de edad
if [[ $test -eq 10 && $age -ge 18 ]]
then
    echo "Puedes salir y tomarte una cerveza"

# Segunda condición
# Si hemos aprobado con menos de un 10 pero somos mayores de edad
elif [[ $test -ge 5 && $test -lt 10 ]] && [ $age -ge 18 ]
then
    echo "Puedes salir, pero nada de alcohol"

# Tercera opción
# Si hemos aprobado pero somos menores de edad, o, si hemos suspendido pero somos mayores de edad
elif [[ $test -ge 5 && $age -lt 18 ]] || [[ $test -lt 5 && $age -ge 18 ]] # En esta situación queremos usar 2 condiciones dobles unidas por un "OR", así que necesitamos usar corchetes dobles sí o sí
then
    echo "Te quedas en casa, pero podrás jugar"

# Salida por defecto
# Por descarte, este caso es cuando suspendamos y seamos menores
else
    echo "Te quedas en casa sin poder jugar"
fi
echo "--------------------------------------------------------------------------------------------------------------"
# --------------------------------------------------------------------------------------------------------------

<<'com'

    En bash tenemos la función 'case', que es una manera sencilla de hacer un menú.
    'case' nos permite definir diferentes ejecuciones para entradas concretas.
    La sintaxis es la siguiente:

    case {variable} in
        {opción 1})
            {comandos que se ejecutan si la variable usada en el 'case' coincide con la opción 1}
        ;;
        {opción 2})
            {comandos que se ejecutan si la variable usada en el 'case' coincide con la opción 2}
        ;;
        *)
            {comandos que se ejecutan si la variable no coincide con ninguna de las opciones}
        ;;
    esac

    Igual que para 'if' el cierre es 'fi',
    para 'case' el cierre es 'esac'

    Para la función 'case', la opción del asterisco (*) es la salida por defecto.

    Vamos a crear un ejemplo sencillo para que quede claro.

com

echo -e "El menú de hoy es el siguiente: \nA) Pizza \nB) Hamburguesa \nC) Ensalada" # En este echo usamos '-e' para habilitar el escape de caracteres usando la barra invertida o "backslash" en inglés (\)
read -p "Elige la opción que quieras hoy: " option
case "$option" in
    "A")
        echo "Has elegido la pizza"
    ;;
    "B")
        echo "Has elegido la hamburguesa"
    ;;
    "C")
        echo "Has elegido la ensalada"
    ;;
    *)
        echo "Lo que has elegido no es una de las opciones"
    ;;
esac
# Ten en cuenta que en el caso de las letras, se comparará léxicográficamente el valor de la variable que has elegido con lo que has definido en cada caso.
# Para este 'case', si el usuario introduce "a", no se mostrará el mensaje de "Has elegido la pizza" ya que '$option' no es "A" (mayúscula).
