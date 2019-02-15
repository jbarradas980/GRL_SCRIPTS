# bash

    Instrucciones de uso
    
          [validaCorreo]
Recibe como parametro 1 el valor de la dirección de correo eléctronico a autentificar, si es correcta aparecerá un mensaje con la siguiente leyenda: "Es valida su CURP", caso contrarío aparecerá lo siguiente: "No es valida su CURP"
Es necesario que la CURP se escriba todas las letras en MAYUSCULAS.

Ejemplo de uso:
	./script.sh "JABM1231234"

Nota: Se debe tener permisos de ejecución para ejecutar el script como anteriormente se mostro.
          [validaCurp]
Descripción:Este script sirve para validar la curp.
Recibe como parametro 1 el valor de la curp a autentificar, si es correcta aparecerá un mensaje con la siguiente leyenda: "Es valida su CURP", caso contrarío aparecerá lo siguiente: "No es valida su CURP"
Es necesario que la CURP se escriba todas las letras en MAYUSCULAS.

Ejemplo de uso:
	./script.sh "BEML920313HMCLNS09"

Nota: Se debe tener permisos de ejecución para ejecutar el script como anteriormente se mostro.

La validación es en el siguiente orden:
> Primera letra y la primera vocal del primer apellido.
> Primera letra del segundo apellido.
> Primera letra del nombre de pila: se tomará en cuenta el primer nombre. Ejemplo: Juan Francisco se tomaria la letra J.
> Fecha de nacimiento sin espacios en orden de año, mes y día. Ejemplo: 960917 (1996, septiembre 17).
> Letra del sexo (H o M).
> Dos letras correspondientes a la entidad de nacimiento (en caso de haber nacido fuera del país, se marca como NE, "Nacido en el Extranjero"; véase el Catálogo de Claves de Entidades Federativas aquí.
> Primera consonante interna () del primer apellido.
> Primera consonante interna () del segundo apellido.
> Primera consonante interna () del nombre.
> Dígito del 0-9 para fechas de nacimiento hasta el año 1999 y A-Z para fechas de nacimiento a partir del 2000.
> Dígito, para evitar duplicaciones.

Referencias:
https://es.wikipedia.org/wiki/Clave_%C3%9Anica_de_Registro_de_Poblaci%C3%B3n : Fecha de consulta: 05/dic/2018

          [interfacesRed]
Descripción: Este script sirve para dar de baja o de alta las interfaces de nuestra red, con base a los parametros que le demos.

Ejemplo de uso:
	./script.sh -u

Nota: Se debe tener permisos de ejecución para ejecutar el script como anteriormente se mostro y con un usuario que tenga permisos sobre el comando ip link ... como ejemplo root, o utilizando sudo configurado para tener los permisos con el usuario que esta ejecutando el script..
