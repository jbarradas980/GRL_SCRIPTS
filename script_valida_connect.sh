#!/bin/bash
#Este script permite validar la cantidad de hosts en una red a la que se le puede hacer ping desde .1 a .254.
#Se pueden cambiar los siguientes valores para definir donde inicia la detección de hosts y donde termina.
INICIA_PING=1
FIN_PING=254
#Se define el tiempo maximo del ping
MAX_TIME=2

[[ $1 ]] || { echo "Debe ingresar una dirección de red. Ejemplo ./script 192.168.1.0"; exit; }

IP_ADDR=$1
DIR_RED=$(echo $IP_ADDR | egrep -o ^[0-9]{1\,3}\.[0-9]{1\,3}\.[0-9]{1\,3}\.)

[[ $DIR_RED ]] || { echo "Ocurrió un error con la dirección de red $IP_ADDR"; }

echo "Iniciando detección de dispositivos que se puede hacer ping..."
echo "Este proceso podría tardar unos minutos"

for host in $(seq $INICIA_PING $FIN_PING); do
	REQUEST=$(ping $DIR_RED$host -c 1 -w $MAX_TIME)
	RESULTADO=$(echo $REQUEST | egrep -o [0-9]{1}' 'received)
	RESULTADO_ENT=$(echo $RESULTADO | egrep -o [0-9]{1})
	#Se imprime en pantalla el dispositivo al cual se establece el ping
	[[ $RESULTADO_ENT -eq 1 ]] && { echo "$DIR_RED$host"; } 
done

