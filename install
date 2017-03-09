#!/bin/bash -u
#This will take a file as first argument, a folder(optional) as a second argument.
#File must be a XZ, which contains code and a Makefile. It will try to compile the code with it, and it will
#tell the user how to launch the compiled code

ROJO="\x1b[1;31m"
BOLD="\x1b[0;1m"
RESET="\x1b[0;0m"
CARPETA="programa"
ANTIGUA_CARPETA=
EJECUTABLE=
RESPUESTA=

if [ $# -gt 2 -o $# -lt 1 ]
then
	echo -e $ROJO"ERROR: Numero de parametros incorrecto"$RESET
	exit 1
fi

#Instalacion y destino no pueden llamarse iguales
if [ "$1" == "$2" ]
then
	echo -e $ROJO"ERROR: El programa no puede llamarse igual que la carpeta de instalacion"$RESET
	exit 1
fi

echo -e $BOLD"Se instalara el programa: "$1
if [ $# -eq 2 ]
then
	echo "Se instalara en la carpeta: "$2
	CARPETA=$2
fi

while [ "$RESPUESTA" != "SI" -a "$RESPUESTA" != "NO" ]; do
	read -p "¿Estas de acuerdo?[SI/NO]" RESPUESTA
	if [ "$RESPUESTA" == "NO" ]
	then
		echo -e $BOLD"Saliendo..."$RESET
		exit 0
	fi
	
	if [ "$RESPUESTA" == "SI" ]
	then
		echo -e $BOLD"Trabajando..."$RESET
	else
		echo -e $ROJO"ERROR: Debes responder exactamente "SI" o "NO " "$RESET
	fi
done
	
#Parametros correctos, se continua
#Comprimir tar cfJ <archive.tar.xz> <folder/*>

if [ -z "$(file "$1" | grep -i "xz compressed")" ]
then
	echo -e $ROJO"ERROR: "$1" no es un archivo XZ"$RESET
	exit 1
fi

if [ -d $CARPETA ]
then
	echo -e $ROJO"ERROR: La carpeta "$CARPETA" ya existe. Borrala antes de continuar "$RESET
	exit 1
fi

mkdir $CARPETA
if [ $? -ne 0 ]
then
	echo -e $ROJO"ERROR: La carpeta "$CARPETA" no pudo ser creada "$RESET
	exit 1
fi

tar xf $1 -C $CARPETA
cd $CARPETA
ANTIGUA_CARPETA=$(ls)
mv $ANTIGUA_CARPETA/* .
rm -rf $ANTIGUA_CARPETA

if [ -z "$(ls | grep Makefile)" ]
then
	echo -e $ROJO"ERROR: No hay un makefile para compilar"$RESET
	exit 1
fi

make > /dev/null 2> /dev/null
if [ $? -ne 0 ]
then
	echo -e $ROJO"ERROR: La compilacion fallo"$RESET
	exit 1
fi

EJECUTABLE=$(cat Makefile | grep  -o "\-o [a-zA-Z]*.*" | cut -d' ' -f2)

if [ -z "$EJECUTABLE" ]
then
	chmod +x a.out
	echo -e $BOLD"La instalacion se realizo correctamente"
	echo -e "Para ejecutar el programa, escribe: "$CARPETA"/a.out"$RESET
else
	chmod +x $EJECUTABLE
	echo -e $BOLD"La instalacion se realizo correctamente"
	echo -e "Para ejecutar el programa, escribe: "$CARPETA"/"$EJECUTABLE $RESET
fi
