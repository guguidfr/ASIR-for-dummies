#!/bin/bash
# José Daniel Fernández López

<<'com'

    En este script vamos a hacer uno de los 'if' más usados y más fáciles: vamos a comprobar
    si se está ejecutando con permisos de 'root'.

    Como deberías de saber, en linux, cada usuario del sistema tiene un identificador único.
    Estas ids las podemos ver en el archivo 'passwd'.

    En el caso del usuario 'www-data', su línea correspondiente en el archivo es la siguiente:
    www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin

    El id del usuario 'www-data' es el número 33, que es el tercer campo contando desde la izquierda.
        (El cuarto campo es el 'gid'; el id del grupo principal del usuario.)
        (Normalmente el id y el gid coinciden)
    
    Ahora que ya sabemos lo del id, veremos cómo obtenerlo.
    
    La manera más sencilla es usar el comando 'id', que en mi caso, en mi equipo, sería algo así:
    > uid=1000(guguidfr) gid=1000(guguidfr) grupos=1000(guguidfr),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),122(lpadmin),135(lxd),136(sambashare)

    ¿Pero y si solamente quiero obtener el valor del id de usuario?
    Usaremos la flag '-u', obteniendo la siguiente salida:
    > 1000

    Sabiendo cómo se obtienen los ids, debes de saber lo más importante: el id del usuario root siempre es el '0'
    Esto se aplica también cuando ejecutamos el comando 'id' con 'sudo'.
        (Ya que como deberías de saber, 'sudo' es la abreviación de 'Super User Do')
    
    Si ejecutamos: 'sudo id -u'
    La salida será:
    > 0

    Todo esto nos lleva a que: si queremos comprobar que el script lo está ejecutando el usuario root, tenemos que comprobar que el
    id del usuario que ha ejecutado el script sea 0.

    También podrás pensar que por qué no verificar el nombre usando 'whoami', ya que al ejecutarlo con 'sudo'
    obtenemos 'root'; esto se debe a que puede haber más usuarios que se llamen 'root' en el sistema,
    pero ninguno de estos 'falsos superusuarios' tendrá de id el '0'.

    Habiendo dejado esto claro, vamos con la verificación de permisos de usuario root.
    
com

# Para comprobar si el id del usuario que ejecuta el script coincide con '0', nos basta con usar un 'if'
if [ $(id -u) -eq 0 ] # Para esta condición usamos la salida del comando para la comparación
then
    echo "Estás ejecutando este script como root"
    exit 0 # En este caso salimos con código '0' porquie todo ha ido correctamente
else
    echo "No eres superusuario"
    exit 1 # Como es necesario que lo ejecute 'root', salimos con código '1'
fi