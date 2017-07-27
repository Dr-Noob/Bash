#!/bin/bash -u

function visualizar {
	##### comprobar la posicion del puntero
	# a lo alto
	h=$(cat $1 | wc -l)
	if [ $h -eq $3 ]
	then
		echo -e "-1\t" >> $1
	fi
	
	# a lo ancho
	linea=$(cat $1 | head -n $((1+$3)) | tail -n -1)
	w=$(echo $linea | wc -w)
	if [ $w -le $2 ]
	then
		for o in $(seq 0 $(($2-w)))
		do
			linea=$(echo -en "$linea-1\t")
		done
		arriba=$(cat $1 | head -n $3)
		abajo=$(cat $1 | tail -n +$(($3+2)))
		echo "$arriba" > $1
		echo "$linea" >> $1
		echo "$abajo" >> $1
	fi
	
	#######################################

	Y=0
	while read l
	do
		X=0
		for n in $l
		do
			if [ $2 == $X -a $3 == $Y ]
			then
				p="+ "
			else
				p="  "
			fi
		
			if [ $n == -1 ]
			then
				echo -ne "\e[0m${p}"
			else
				echo -ne "\e[48;5;${n}m${p}"
			fi
		
			let X=X+1
		done
		echo -e "\e[0m"
		let Y=Y+1
	done < $1
}

if [ $# -ne 2 ]
then
	echo 'Uso: '$0' directorio numero'
	echo 'El directorio debe contener al menos un archivo donde este guardado una imagen en el formato adecuado'
	echo 'El numero representa el delay. Un delay que suele funcionar bien es 0.1' 
	exit 1
fi

if [ ! -d "$1" ]
then
	echo -e "\033[1;31m"ERROR: "$1" no es un directorio"\033[0m"
	exit 1
fi

if ! [[ "$2" =~ ^-?[0-9]+.?[0-9]*$ ]]
then
	echo -e "\033[1;31m"ERROR: "$2" no es un numero"\033[0m"
	exit 1
fi

frames=$(ls $1 | wc -l)
let frames=frames-1
delay=$2

#Comprobar que todos los archivos son imagenes validas
for c in $(ls $1)
do
	#Para cada archivo
	while read l
	do
		#Para cada linea
		for n in $l
		do
			#echo 'Mirando '$n
			if ! [[ "$n" =~ ^([0-9]|[0-9][0-9]|[12][0-9][0-9]|-1)$ ]]
			then
				echo -e "\033[1;31m"ERROR: El archivo $c no es una imagen valida"\033[0m"
				exit 1
			fi
		done
	done < $1/$c
done 

if [ $delay -lt 0 ]
then
	for i in $(seq 0 $frames)
	do
		clear
		visualizar $1/$i -1 -1
	done
	sleep infinity
fi

#Añadir tecla escape
while true
do
	for i in $(seq 0 $frames)
	do
		clear
		visualizar $1/$i -1 -1
		sleep $delay
	done
done
