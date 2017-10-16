#!/bin/bash -u
#Añade eventos/fechas que se quieren registrar(nombre y dia) al bashrc, de manera que, cuando se inicia la terminal, avisa de cuantos
#dias quedan para una fecha determinada. Se puede añadir, eliminar, consultar las fechas y eliminarlos todos a la vez
#VARIABLES
calculo=0
reg=0
error=$(mktemp)
#FIN_VARIABLES

# Comprobar que el bashrc es accesible
ls $HOME/.bashrc > /dev/null 2> /dev/null
if [ $? -ne 0 ]
then
	echo	'ERROR: Ha habido un fallo al acceder al bashrc en '$HOME/.bashrc
	echo	'Es posible que el fichero no exista, o que el script no tenga suficientes permisos para acceder a él'
	exit 1
else
	cp $HOME/.bashrc $HOME/.backupBASHRC
fi

if [ $# -eq 0 ]
then
	echo 'Se esperaban parámetros'
	echo $0' help muestra la ayuda'
	exit 1
fi

if [ $# -eq 1 ]
then
	if [ $1 == "help" ] # hacer el add
	then
		echo	'Uso: '$0' show|help|del|add opciones'
		echo	'show -> Muestra los registros guardados'
		echo	'help -> Muestra este menú'
		echo	'del -> Eliminar una fecha de la agenda. El segundo parámetro debe ser la clave de la fecha a eliminar, excepto que sea el parámetro "all", en cuyo caso se eliminarán todos los registros'
		echo	'add -> Añade una fecha a la agenda. El segundo parámetro debe ser cuánto tiempo queda para el suceso y el tercero, la clave'
		echo	'La clave representa el suceso que se quiere registrar'
		echo	'Ejemplo: '$0' add 50 ISO -> En el día en el que se registra, el mensaje sería: "Quedan 50 días para ISO"'
		echo	'Ejemplo: '$0' del ISO -> Se elimina el registro en la agenda que contenga la clave ISO'
		exit 1
	elif [ $1 == "show" ] #hacer el show
	then
		cat $HOME/.bashrc | grep -w "#Registro " 2> /dev/null > $error
		if [ ! -s $error ] # Si está vacío
		then
			echo 'No hay ningún registro actualmente'
			exit 1
		fi
		echo 'Los siguientes registros están activos: '
		cat $HOME/.bashrc | grep -w "#Registro " | cut -d' ' -f2
	elif [ $1 == "add" ]
	then
		echo 'add necesita 3 parámetros'
		echo $0' help muestra la ayuda'
		exit 1
	elif [ $1 == "del" ]
	then
		echo 'add necesita 2 parámetros'
		echo $0' help muestra la ayuda'
		exit 1
	else
		echo 'Se esperaba el parámetro "help"'
		exit 1
	fi
fi

if [ $# -eq 2 ]
then
	if [ $1 == "del" ] # hacer el del
	then
		if [ $2 == "all" ] #delete all
		then
			# Comprobar que hay al menos 1
			cat $HOME/.bashrc | grep -w "#Registro " 2> /dev/null > $error
			if [ ! -s $error ] # Si está vacío
			then
				echo 'No se ha borrado ningún registro porque no había ninguno creado'
				exit 1
			fi
			
			#Eliminar todos
			reg=$(cat $HOME/.bashrc | grep -nw "#Registro >>.*<<" | cut -d':' -f1 2> /dev/null  | head -n +1) #En el grep se usa una expresión regular
			while [ ! -z "$reg" ]
			do
				calculo=$(cat $HOME/.bashrc | grep -w "#Registro >>.*<<" | head -n +1)
				sed -i $reg'd' $HOME/.bashrc
				sed -i $reg'd' $HOME/.bashrc
				echo 'Registro '$calculo' eliminado'
				reg=$(cat $HOME/.bashrc | grep -nw "#Registro >>.*<<" | cut -d':' -f1 2> /dev/null | head -n +1)
			done
			echo 'Todos los registros han sido eliminados'
			
			exit 0		
		fi
		
		# Se intenta eliminar el registro
		reg=$(cat $HOME/.bashrc | grep -nw "#Registro >>"$2"<<" | cut -d':' -f1 2> /dev/null )
		if [ $reg -eq 0 2> $error ]
		then
			echo 'El registro no se ha borrado porque no existía ninguno con la clave "'$2'"'
			exit 1
		elif [ -s $error ] # el "-s $error" comprueba si el fichero es no-nulo
		then
			echo 'El registro no se ha borrado porque no existía ninguno con la clave "'$2'"'
			exit 1
		fi
		sed -i $reg'd' $HOME/.bashrc
		sed -i $reg'd' $HOME/.bashrc
		echo 'Registro '$2' eliminado'
	elif [ $1 == "add" ]
	then
		echo 'add necesita 3 parámetros'
		echo $0' help muestra la ayuda'
		exit 1
	else
		echo 'Se esperaba el parámetro "del"'
		exit 1					
	fi
fi

if [ $# -eq 3 ]
then
	if [ $1 == "add" ] # hacer el add
	then
		# Se intenta añadir el registro
		if ! [[ $2 =~ ^[0-9]+$ ]] ; then # OJO, eso es una Expresión Regular
			echo $2' no es un número'
			exit 1
		fi
		# Vemos si el registro existe anteriormente
		cat $HOME/.bashrc | grep -nw "#Registro >>"$3"<<" | cut -d':' -f1 2> /dev/null > $error
		if [ -s $error ] # Si no está vacío
		then
			echo 'El registro "'$3'" ya existía, así que no se crea uno nuevo'
			exit 1
		fi
		# Se añade
		calculo=$(echo $(($(date +%j | sed 's/^0*//')+$2)))
		echo	"#Registro >>"$3"<<" >> $HOME/.bashrc
		echo 	'echo Quedan $(('$calculo'-$(date +%j | sed 's/^0*//'))) días para '$3  >> $HOME/.bashrc #El sed es para eliminar los ceros, para que bash no los confunda con octal
		echo 	'Registro '$3' añadido para dentro de '$2' dias'
	else
		echo 'Se esperaba el parámetro "add"'
		exit 1		
	fi
fi

