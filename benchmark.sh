#!/bin/bash -u
#Prueba un ejecutable un numero n de veces y obtiene la media en milisegundos
#Se recomienda hacer pruebas siempre con la misma carga de cpu, preferiblemente, la minima posible

if [ $# -ne 3 ]
then
	echo 'Uso: benchmark <ejecutable> <entrada> <veces a ejecutar>'
	exit 1
fi

ls $1 > /dev/null 2> /dev/null
if [ $? -ne 0 ]
then
	echo 'El archivo especificado no existe'
	exit 1
fi

./$1 < $2 > /dev/null 2> /dev/null
if [ $? -ne 0 ]
then
	echo 'El archivo especificado no es un ejecutable'
	exit 1
fi

echo 'Ejecutando...'
fichero=$(mktemp)
i=$3
tiempo=0
segundos=0
milisegundos=0
minutos=0
contador=0
while [ $i -ne 0 ]
do
	tiempo=$((time ./$1 < $2 > /dev/null 2> /dev/null) 2> $fichero; cat $fichero)
	segundos=$(cat $fichero | cut -f2 -d$'\t' | head -n +2 | tail -n +2 | cut -d'm' -f2 | cut -d's' -f1 | cut -d'.' -f1)
	milisegundos=$(cat $fichero | cut -f2 -d$'\t' | head -n +2 | tail -n +2 | cut -d'm' -f2 | cut -d's' -f1 | cut -d'.' -f2)
	minutos=$(cat $fichero | cut -f2 -d$'\t' | head -n +2 | tail -n +2 | cut -d'm' -f1)
	if [ $segundos -ne 0 ]; then milisegundos=$(echo $segundos | sed 's/^0*//'); fi
	if [ $milisegundos -ne 0 ]; then milisegundos=$(echo $milisegundos | sed 's/^0*//'); fi
	let minutos=$minutos*60	
	let segundos=$segundos+$minutos
	let milisegundos=$milisegundos+$segundos*1000
	let contador=$contador+$milisegundos
	let i=$i-1
done

let contador=$contador/$3
echo 'La media de ejecucion es: '$contador' milisegundos'

rm $fichero
