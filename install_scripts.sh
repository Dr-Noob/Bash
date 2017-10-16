#!/bin/bash -u
#No comprueba que habia en el directorio antes
ROJO="\x1b[1;31m"
VERDE="\x1b[1;32m"
BOLD="\x1b[0;1m"
RESET="\x1b[0;0m"

if [ $# -ne 1 ]
then
	echo -e $ROJO'ERROR: Se esperaba un directorio'$RESET
  echo 'Uso: '$0' directorio'
  echo '"'$0' -h" muestra la ayuda'
	exit 1
fi

if [ $1 == "-h" ] # mostrar ayuda
then
  echo 'Mostrando ayuda:'
  echo 'Este script instala los scripts del repositorio Bash de Dr-Noob(https://github.com/Dr-Noob/Bash)'
  echo '"'$0' dir" Especifica el directorio donde se almacenaran los ficheros .sh'
  echo '"'$0' -h" Muestra esta ayuda'
  echo 'Para mas informacion, visita el repositorio citado previamente'
  exit 0
else
  if [[ ! -d $1 ]]
  then
  	echo -e $ROJO'ERROR: '$1' no es un directorio valido'
  	exit 1
  fi
  if [[ $1 -ef $PWD ]]
  then
  	echo -e $ROJO'ERROR: '$1' es el directorio actual'
  	exit 1
  fi
fi

#Comprobar que el BASHRC es accesible
BASHRC=$HOME/.bashrc
ls $BASHRC > /dev/null 2> /dev/null
if [ $? -ne 0 ]
then
	echo	'ERROR: Ha habido un fallo al acceder al bashrc en "'$BASHRC'"'
	echo	'Es posible que el fichero no exista, o que el script no tenga suficientes permisos para acceder a el'
	exit 1
fi

# Todo es correcto, instalar los scripts
echo -e $VERDE'Bienvenido al instalador de Dr-Noob'$RESET
echo 'Los scripts se moveran al directorio "'$1'"'

cp *.sh $1
if [ $? -ne 0 ]
then
  echo -e $ROJO'ERROR: Fallo al mover los scripts al directorio ""'$1'"'
  exit 1
fi

rm $1/$0
if [ $? -ne 0 ]
then
  echo -e $ROJO'ERROR: Fallo al mover los scripts al directorio ""'$1'"'
  exit 1
fi

cd $1
if [ $? -ne 0 ]
then
  echo -e $ROJO'ERROR: Fallo al acceder al directorio ""'$1'"'
  exit 1
fi

echo '######INSTALACION_SCRIPTS_DR_NOOB######' >> $BASHRC
if [ $? -ne 0 ]
then
  echo -e $ROJO'ERROR: Fallo al escribir en ""'$BASHRC'"'
  exit 1
fi

for c in *
do
  name=$(echo $c | rev | cut -c 4- | rev)
  echo alias $name=\'$(realpath $c)\' >> $BASHRC
  chmod +x $c
done

echo '#######################################' >> $BASHRC
source $BASHRC

echo '¡Hecho!'
echo 'Si quieres empezar a  utilizarlos ya, ejecuta "source '$BASHRC'"'

exit 0
