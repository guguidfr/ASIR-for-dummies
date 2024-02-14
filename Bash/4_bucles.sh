#!/bin/bash
# José Daniel Fernández López

<<'com'

    A la hora de crear scripts, nos encontraremos situaciones en las que tendremos que repetir un comando o una serie de pasos más de una vez.
    Para evitar la repetición de código contamos con lo que llamamos "bucles".
    En bash tenemos 2 bucles: "for" y "while".
    Con "for" podemos hacer un número determinado de repeticiones, por lo que siempre tendremos el control, lo que evitará que hagamos bucles infinitos o se hagan más repeticiones de las necesarias.
    Con "while" podemos crear tanto bucles "infinitos" como bucles con repeticiones concretas (aunque no sea su uso principal).
    El operador "while" se usa cuando queremos repetir algo mientras una condición se cumpla o hagamos que la salida sea forzosa. Es útil cuando queremos un programa interactivo con el usuario.

    Además, cuando necesitemos leer un archivo de texto línea a línea, usaremos "while" (porque normalmente no sabremos cuántas líneas tiene en total, así que ejecutaremos el bucle hasta la última línea).
    Este tipo de bucles son más sencillos ya que a la hora de expresar la condición, es lo mismo que cuando definimos la de un "if".
    Entrando algo más en detalle sobre el funcionamiento de "while", como he dicho antes, se va a ejecutar siempre y cuando una condición sea verdadera, como [ 1 -eq 1 ]; en este ejemplo de condición,
    nuestro bucle se ejecutará siempre, ya que uno siempre será igual a uno. En casos como este, para detener el bucle, tendremos que usar sentencias que fuercen la salida, ya sea del bucle, como "break",
    o "exit", para salir directamente de la ejecución del script.
    Usar "exit", en los scripts en general, es una buena práctica si queremos definir diferentes códigos de errores en un script complejo, ya que si sabemos que pueden ocurrir fallos que no podemos arreglar,
    podemos añadir documentación en la que digamos qué significa cada código (aunque lo común es, sencilamente, hacer bien tu script para que no falle, pero habrá ocasiones en las que los errores no vendrán
    de tu script, si no de algún tercero como una API u otro programa o servicio).

    Crear una salida controlada mediantes variables de tipo booleanas (variables que solamente van a contener los valores para "true" o "false") es una buena práctica y más fácil de controlar.
    De manera resumida y con lenguaje sencillo, usar una variable booleana para un bucle "while" se resume en:
    - Crear una variable antes del bucle con el valor "true" (puedes establecer su valor en "True" o "1").
    - Definir la condición del bucle usando la variable antes creada, como: [ $check = True ]
    - Dentro del bucle, crear un "if" que verifique la condición que queremos que haga que el bucle se detenga, como comprobar si una suma que se ha ido repitiendo ha llegado a 50: if [ $sum -eq 50 ]
    - Ya en la parte del "if" que se ejecuta en caso de que la condición sea verdadera, modificar la variable booleana que usamos para el bucle: check=False
    (Importante: estas comprobaciones se suelen poner al principio o al final del bucle, dependiendo de lo que queramos hacer para la última ejecución. Esto también nos permite tener un código más ordenado. Lo veremos más adelante.)
    - Con la variable ya en "False", cuando se vaya a ejecutar el bucle de nuevo, la condición del "while" ya no se cumplirá, por lo que no entraremos de nuevo en el bucle, y seguiremos con el resto del código.

    ----------------------------------------------------------------------------------------------------------------------

    El bucle "for" normalmente lo usaremos para iterar un número definido de veces, por lo que tendremos el control total de la ejecución (siempre y cuando lo escribamos correctamente, claro).
    Se suele usar directamente con números, o pasando por los elementos de una lista; a veces también lo podemos combinar con comandos propios de linux como el "ls", lo que nos permite pasar de manera controlada por todos los archivos, por ejemplo.

    Un dato imporante a tener en cuenta de "for" es que se puede escribir de dos manera diferentes: con la sintaxis tradicional de bash, o con una sintaxis igual a la usada en el lenguaje C.
    Dependiendo de la situación en la que tengas que usar el bucle o cuál te guste más, acabarás usando uno u otro.

com

# Vamos primero con el bucle while, que es más sencillo.
# En el siguiente bloque de comentario voy a definir un bucle infinito. Puedes ejecutarlo, pero tendrás que detener manualmente el proceso luego.
<<'com'

    while True
    do
        echo "Hello World!"
    done

com
# Aunque normalmente no es buena idea que tengas en ejecución un bucle infinito, puede que haya situaciones en las que quieras tener algo siempre en ejecución en tu equipo.
# Puede resultarte útil si, por ejemplo, quieres ver cada 5 minutos el estado de la memoria de tu servidor en una pantalla.
# Tendrías que usar los comandos "date", "free", "sleep" y "clear" dentro de un "while true".
# Bucles como estos normalmente van a ser sencillos, por lo que no consumirán mucha CPU o RAM, así que los puedes usar para monitorizar de manera constante.
# Hay alternativas mejores den Linux, como el uso de Cron, pero para tareas sencillas que quieres tener siempre en pantalla, pueden venir bien.
# -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Ahora, con un bucle que pueda resultar más útil (aunque llevado a lo más simple) y que acabarás usando:
num=1
check=True
while [ $check = True ]
do
    echo "El valor actual del número es: $num"
    ((num++))
    if [ $num -eq 15 ]
    then
        check=False
    fi
done
echo "-------------------------------------------------------------"
# En este primer caso, hemos puesto la condición al final del bucle y, como podrás comprobar en su ejecución, el valor máximo que se nos muestra en pantalla es 14.
# Esto se debe a que "while" siempre al final de cada iteración si la condición se sigue cumpliendo.
# En este bucle, donde primero se suma y luego se compara para cambiar el valor de nuestra variable de control, al estar justo al final de la ejecución, nunca se llegará a mostrar 15 por pantalla.
# En la iteración en la que el número valga 14, luego se le sumará 1, pasando a 15, y se comprobará que, efecitvamente, vale 15.
# Se cambia a "False", y ya en la siguiente iteración "while" verá que se ha cambiado a "False", por lo que no se ejecutará de nuevo, dejándonos solamente en la terminal hasta el valor 14.
# Si ponemos la comparación al principio, nos quedará así:
num=1
check=True
while [ $check = True ]
do
    if [ $num -eq 15 ]
    then
        check=False
    fi
    echo "El valor actual del número es: $num"
    ((num++))
done
# Esta vez el orden es: verificar, mostrar y sumar.
# En la ejecución verás que esta vez si llegaremos a ver que el número vale 15 ya que, en la iteración en la que ya vale 15, como la comparación se hace al principio, "while" lo "notará" en la siguiente.
# Dependiendo de lo que quieras para la última ejecución, pondrás la comprobación al principio o al final.
# -------------------------------------------------------------------------------
# Igualmente, para estos casos en los que vas a querer ejecutar algo determinadas veces, es más recomendable usar un bucle "for".
# -------------------------------------------------------------------------------
# Una variante de esto que acabas de ver, se puede usar con salida forzosa, aunque ya te he dicho que no es lo más recomendable.
<<'com'

    num=1
    while True
    do
        echo "El valor actual del número es: $num"
        ((num++))
        if [ $num -eq 15 ]
        then
            break
        fi
    done

com
# Para que se entienda bien "break", puedes pensar que es como literalmente "romper el bucle".
