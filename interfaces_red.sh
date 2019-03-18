#!/bin/bash
#Fecha de creación: 15 / Febrero / 2019
#Script para dar de alta o de baja todas las interfaces de nuestro computador, esto con la paqueteria iproute2
function modoUso(){
	echo "Script para dar de baja o alta todas las interfaces de red"
	echo " sudo [OPCIONES] ./interfaces"
	echo "	OPCIONES:"
	echo "-u : Da de alta todas las interfaces"
	echo "-d : Da de baja todas las interfaces"
	exit 1;
}

function interfaces_control {
	for interface in $(ip link show | egrep -o "^[0-9]+: [a-z][a-z0-9]*" | egrep -o "[a-z][a-z0-9]*"); do
		ip link set $interface $1
	done
}
OPT_U=0
OPT_D=0
[[ $2 ]] && { modoUso; }
while getopts ":ud" opt; do
	case $opt in
		u)
			OPT_U="up"
			;;
		d)
			OPT_D="down"
			;;
		\?)
			modoUso;
			;;
	esac
done

[[ $OPT_U == "up" ]] && { interfaces_control $OPT_U; }
[[ $OPT_D == "down" ]] && { interfaces_control $OPT_D; }
