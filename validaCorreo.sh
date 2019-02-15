#!/bin/bash
#Elaboró: 						JABM
#Fecha: 						05 de Diciembre del 2018
#Ultima fecha de modificación:	05 de Diciembre del 2018
#Descripción: Este script permite validar el correo que se introduzca como parametro 1
function modoUso (){
	echo "Este script sirve para validar correos"
	echo "./validarCorreo.sh CORREO"
	echo "Correo: es una cadena que representa un correo"
}

#Si cumple con la expresión regular: le dará un valor a resultado.
resultado=$(echo $1 | egrep -c "^[a-zA-Z][a-zA-Z0-9\.-_]*@[a-zA-Z][a-zA-Z0-9\.-_]+\.[a-zA-Z0-9]+$")

[[ $resultado -eq $1 ]] && echo "Es un correo valido" || echo "Es un correo invalido"
exit