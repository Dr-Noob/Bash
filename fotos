#Al descargar las fotos de flickr en un ordenador, es posible que se organizen por defecto en carpetas, y se guarden
#mas cosas a parte de las imagenes. Este script mueve las fotos, que es lo que interesa tener, a una carpeta aparte
#!/bin/bash -u

carpetaFotos=0
i=0

if [ $# -gt 1 ]
then
	echo 'Error: No se admite mas de un parametro'
	exit 1
fi

if [ $# -eq 1 ]
then
	if [ $1 == "help"]
	then
		echo ${0##*/}' movera las fotos de flickr de todas las carpetas a una unica'
		echo 'Se puede especificar la carpeta para crear, poniendo el nombre despues de este programa, asi:'
		echo $0' ejemplo(en cuyo caso creará la carpeta ejemplo'
		echo 'Si no se especifica nada, se creará en "Fotos"'
		echo 'En cualquier caso la carpeta no puede existir al ejecutarse el programa' 
	else
		carpetaFotos=$1
		echo 'Las fotos se guardaran en la carpeta '$carpetaFotos
	fi
else
	carpetaFotos=Fotos
fi


rm *.html 2> /dev/null

if [ -d "$carpetaFotos" ]
then
	echo 'Error: La carpeta '$carpetaFotos' existe. Es necesario eliminarla para que este programa funcione'
	echo 'Saliendo...'
	exit 1
fi

mkdir $carpetaFotos

i=$(ls -l | grep -vw ${0##*/}  | grep -vw $carpetaFotos | wc -l)
let i=$i-1

if [ $i -le 0 ]
then
	echo 'Error: No hay nada que mover'
	echo 'Saliendo...'
	exit 1
fi

echo 'Hay '$i' fotos' 
for c in $(seq 1 $i)
do
	dir="$(ls | grep -vw ${0##*/}  | grep -vw $carpetaFotos | head -n +$c | tail -n +$c)"
	if [ "$(ls -A "$dir")" ] #estas comillas del $dir y otras sirven para que los directorios con espacios no fallen
	then	#directorio no-vacio
     		foto=$(find "$dir" -printf "%s %f\n" | grep -v js | grep -v ad | grep -v css | sort -nr -k2 | head -n +1 | cut -d' ' -f2)
		cp "$dir/$foto" $carpetaFotos
		if [ $? -eq 0 ]
		then
			echo 'Foto '$foto' movida correctamente'
		else
			echo 'Error al intentar mover '$foto
			echo 'Saliendo...'
			exit 1
		fi
	else	#directorio vacio
    		echo 'Carpeta '$dir' esta vacia. Se omite'
	fi	
done

echo 'Todas las fotos se movieron con exito'
exit 0
