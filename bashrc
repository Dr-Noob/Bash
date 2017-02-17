#bashrc del root modificado. Muestra un mensaje aleatorio de los que se guardan en las variables. Es necesario que se actualize
#la variable fn, que indica el numero de variables que contengan una frase. Además, establece un prompt en rojo(Los mensajes en
#f1,f2,f3,f4 son solo un ejemplo, son modificables y es posible añadir mas)

fn=4
f1="Be careful, kid"
f2="With great power comes great responsability"
f3="I wanted to save the world"
f4="Hello friend"
ff=$(eval echo \$f$(((RANDOM%$fn)+1)))

echo -e "\033[1;31m"$ff"\033[0m"
PS1='\[\e[1;31m\][\u@\h \W]\$\[\e[0m\] '
