#!/bin/bash -u
#FUNCIONA UNICAMENTE EN GNOME
################################################################################################
##Establece una imagen de manera aleatoria como fondo de escritorio y otra como salvapantallas##
################################################################################################
#Es necesario poner en ruta(justo abajo)la ruta de donde se quieren coger las imagenes
ruta=
#ruta=/home/usuario/Imagenes/Wallpapers
#Es posible lanzarlo al iniciar el pc, una forma de hacerlo es guardandolo como /etc/systemd/system/randomwallpapers.service,
#ejecutar systemctl enable randomwallpapers.service y por ultimo añadir una linea en /etc/profile, especificando la ruta donde
#se encuentra el propio script.
i=$(ls -1 $ruta | wc -l)
aleatorio1=$((1 + RANDOM % i))
aleatorio2=$((1 + RANDOM % i))
string1=$(ls $ruta | head -$aleatorio1 | tail -1)
string2=$(ls $ruta | head -$aleatorio2 | tail -1)

gsettings set org.gnome.desktop.background picture-uri "file:////$ruta/$string1"
gsettings set org.gnome.desktop.screensaver picture-uri "file:///$ruta/$string2"
