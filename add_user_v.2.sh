#!/bin/bash

function modoUso () {
	echo "Uso de script: Agregar usuarios v1."
	echo "Este script sirve para agregar nuevos"
	echo "usuarios."
	echo " Ejemplo:"
	echo "	./add_user.sh USUARIO"
	echo "				@JABM v1.16"
	exit $1;
}
function modoPss (){
	echo "La contrseña debe terner minimo 8 caracteres";
	echo "La contraseña debe contar con mínimo lo siguiente 1 de los siguientes caracteres: ";
	echo " 1.- Una palabra minuscula."
	echo " 2.- Una palabra mayuscula."
	echo " 3.- Un número."
	echo " 4.- Un simbolo."
	echo "Ejemplo: \$1sT3rP0r\$1x"
	exit 4;
}
function val_null () {
	[[ ! "$1" ]] && { echo "Debe ingresar un valor :("; exit 2; }
}
function chr_ascii ()  {
        printf "\\$(printf '%03o' "$1")";
}
function ascii_chr {
        LC_CTYPE=C printf '%d' "'$1"
}

#Se valida que el usuario exista
[[ ! "$1" ]] && { modoUso 3; }
#[[ $(cat /etc/passwd | grep "$1") ]] && { echo "El usuario ["$1"] ya existe"; modoUso 1; }

# # # 		DECLARACIÓN DE VARIABLES 	# # #
B_DIR=0 #Bandera para generar dir home =1
B_SKE=0 #Nandera para usar skel =2
B_SHE=0 #Bandera para usar shell =4
# # # INICIA DECLARACION DEL COMENTARIO # # #
echo "Inserte el nombre del personal que usuara el usuario: "
read V_COMMENT
val_null "$V_COMMENT"

# # # INICIA DECLARACION DEL GRUPO # # #
echo "Inserte el nombre del grupo al que pertenecera el usuario: "
read V_GROUP
val_null "$V_GROUP"
if [ ! "$(cat /etc/group | grep "$V_GROUP:")" ]; then 
        echo "El grupo ["$V_GROUP"] no existe"; 
	echo "Desea crear un nuevo grupo con el nombre de "$V_GROUP". (Y/n)"
	read OPT_YN
	[[ "$OPT_YN" == "n" ]] && { echo "Error el grpo no existe"; } || { groupadd "$V_GROUP"; }
	[[ ! $? -eq 0 ]] && { echo "Error al crear grupo, valide que tenga los permisos..."; exit 2; }
fi

# # #	INICIA DECLARACIÓN DE DIRECTORIO HOME # # #
echo "El directorio home del usuario será: \"/home/$1/\""
echo "	¿Desea cambiarlo? (Y/n)"
read OPT_YN

if [ "$OPT_YN" == "n" ]; then
	V_DIR="/home/$1/"	
else
	echo "Ingrese el directorio del usuario:"
	echo "Debe ingresar el direcotiro completo, para evitar posibles errores."
	echo "		Ejemplo /tmp/dir_user/"
	read V_DIR
fi
if [ ! -d "$V_DIR" ]; then
        echo "El directorio $V_DIR no existe, se va a generar el directorio (Aun no :3).";
	B_DIR="1";
fi


# # #	INICIA DECLARACIÓN DE DIRECTORIO SKEL # # #
echo "¿Desea usar algún directorio \"skel\" para este usuario? (y/N)"
read OPT_YN
if [ "$OPT_YN" == "y" ]; then
	B_SKE="2"
	echo "Se usará \"/etc/skel\"";
	echo "¿Desea cambiar el directorio? (Y/n)";
	read OPT_YN;
	if [ "$OPT_YN" == "n" ]; then
		V_SKE="/etc/skel";
	else 
		echo "Introducta el directorio a utilizar: "
		read V_SKE
		[[ ! -d "$V_SKE" ]] && { echo "Error al leer directorio, valide que exista, se cancelará esta opción..."; $B_SKE=0; }
	fi
fi

# # #	INICIA DECLARACIÓN DE SHELL # # #
echo " ¿Desea agregar algún shell para este usuario? (y/N)"
read OPT_YN
if [ "$OPT_YN" == "y" ]; then
	B_SHE="4"
	echo "Introducta el shell a utilizar: "
	echo "	Ejemplo: /bin/bash"
	read V_SHE
	[[ ! -f "$V_SHE" ]] && { echo "Error al ingresar shell, se anulará la opción"; $B_SHE=0; }
fi
#Inicia validación de contraseña
echo "Inserte una contraseña para el usuario $1: "
read V_PASS
COUNTER=0
B_PASS=1;
echo "Longitud de la contrseña: $L_PASS"

[ ${#V_PASS} -lt 8 ] && { echo "La contraseña debe contener minimo 8 caracteres"; B_PASS="0"; }
COUNTER=0
B_NUM=0;
B_SIM=0;
B_MAY=0;
B_MIN=0;
B_PSS=""; # Acumula las B anteriores :v
b_NUM=0;
b_SIM=0;
b_MAY=0;
b_MIN=0;
while [ $COUNTER -lt ${#V_PASS} ]; do
	C_INT=$(echo "${V_PASS: $COUNTER: $(($CONTER+1))}" | tr -d "\n"| od -An -t dC)
	[[ $C_INT -ge 65 ]] && [[ $C_INT -le 90 ]] && { B_MAY=$(($B_MAY+1)); b_MAY="1"; }
	[[ $C_INT -ge 48 ]] && [[ $C_INT -le 57 ]] && { B_NUM=$(($B_NUM+1)); b_NUM="1"; }
	[[ $C_INT -ge 97 ]] && [[ $C_INT -le 122 ]] && { B_MIN=$(($B_MIN)); b_MIN="1"; }
        [[ $C_INT -ge 33 ]] && [[ $C_INT -le 47 ]] && { B_SIM=$(($B_SIM+1)); b_SIM="1"; }
        [[ $C_INT -ge 58 ]] && [[ $C_INT -le 64 ]] && { B_SIM=$(($B_SIM+1)); b_SIM="1"; }
        [[ $C_INT -ge 91 ]] && [[ $C_INT -le 96 ]] && { B_SIM=$(($B_SIM+1)); b_SIM="1"; }
        [[ $C_INT -ge 123 ]] && [[ $C_INT -le 254 ]] && { B_SIM=$(($B_SIM+1)); b_SIM="1"; }
        COUNTER=$(($COUNTER+1))
done
let B_PSS=$b_MAY+$b_NUM+$b_MIN+$b_SIM
#B_PSS=$(("$b_MAY"+"$b_MIN"))
#B_PSS=$(("$B_PSS"+"$b_NUM"))
#B_PSS=$(("$B_PSS"+"$b_SIM"))
[[ $B_PSS -lt 4 ]] && { modoPss; } 
#Termina validación de contraseña
let T_BAN=$B_DIR+$B_SKE+$B_SHE

[[ $T_BAN -eq 0 ]] && { useradd -c "$V_COMMENT" -d "$V_DIR" -g "$V_GROUP" "$1"; }

[[ $T_BAN -eq 1 ]] && { mkdir "$V_DIR"; useradd -c "$V_COMMENT" -d "$V_DIR" -g "$V_GROUP" "$1"; }

[[ $T_BAN -eq 2 ]] && { useradd -c "$V_COMMENT" -d "$V_DIR" -g "$V_GROUP" -k "$V_SKE" "$1"; }

[[ $T_BAN -eq 4 ]] && { useradd -c "$V_COMMENT" -d "$V_DIR" -g "$V_GROUP" -s "$V_SHE" "$1"; }

[[ $T_BAN -eq 3 ]] && { mkdir "$V_DIR"; useradd -c "$V_COMMENT" -d "$V_DIR" -g "$V_GROUP" -k "$V_SKE" "$1"; }

[[ $T_BAN -eq 5 ]] && { mkdir "$V_DIR"; useradd -c "$V_COMMENT" -d "$V_DIR" -g "$V_GROUP" -s "$V_SHE" "$1"; }

[[ $T_BAN -eq 6 ]] && { useradd -c "$V_COMMENT" -d "$V_DIR" -g "$V_GROUP"; -k "$V_SKE" -s "$V_SHE""$1"; }

[[ $T_BAN -eq 7 ]] && { mkdir "$V_DIR"; useradd -c "$V_COMMENT" -d "$V_DIR" -g "$V_GROUP" -k "$V_SKE" -s "$V_SHE" "$1"; }

echo "$1:$V_PASS" | chpasswd -m


