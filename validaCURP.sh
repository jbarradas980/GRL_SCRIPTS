#!/bin/bash
#Elaboró: 						JABM
#Fecha: 						05 de Diciembre del 2018
#Ultima fecha de modificación:	05 de Diciembre del 2018
#Descripción: Este script permite validar la curp que se introduzca como parametro 1
function modoUso() {
    echo "Este script sirve para validar correos"
    echo "./validarCURP.sh CURP"
	echo "CURP: es una cadena que representa la curp a validar"
}

[[ $1 ]] || { modoUso; exit 1; }

#Si no se cumple la siguiente expresión regular res='', validación en READM.txt
res=$(echo $1 | egrep -c "^[A-Z]{4}+[0-9]{6}+[HM]{1}+[A-Z]{2}+[BCDFGHJKLMÑPQRSTVWYZ]{3}+[0-9|A-Z]{1}+[0-9]{1}")

#Si la variable "res" es igual al parametro 1 significa que se cumplieron las caracteristicas de la curp.
[[ $res -eq $1 ]] && echo "Es valida su CURP" || echo "No es valida su CURP"