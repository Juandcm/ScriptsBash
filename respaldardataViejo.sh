#!/bin/bash
#Configuración de variables de entorno

#Antes de hacer cualquier cambio tengo que crear una carpeta en el server con el nombre Respaldosbd que puede estar guardada en el home
#configuración de usuario, clave y directorio
user='seead'
host='10.10.10.3'
#Aqui va a ir la direccion donde se guardaran los archivos
primera=/media/servidor/RespaldoServer3/Nueva/*
dir=/media/servidor/RespaldoServer3/Nueva/RespaldoDatos_`date '+%Y%m%d'`

#Aqui borro los archivos o carpetas viejos de los respaldos viejos, tengo que cambiar el 0 por 3 para que tenga una antiguedad de 3 dias
find $primera -type d -mtime +30 -exec rm -R {} \;

mkdir -p $dir;

# Array para seleccionar las carpetas a guardar
directorios=(
"/Respaldosbd"
"/etc"
"/var"
"/home"
)

# Se descarga de manera recursiva los archivos del server 19
for direccion in "${directorios[@]}"; do
	scp -r $user@$host:$direccion $dir
	echo "Guardando la dirección del servidor 3: "$direccion
	echo "en: "$dir
done

#aqui tengo que comprimir los archivos:
# Una vez descargado todo los archivos, ahora se comprimen y luego se borran las carpetas
for direccioncomprimir in "${directorios[@]}"; do
        #Aqui tengo que comprimir la carpeta
        tar cfvz "$dir/${direccioncomprimir/'/'/}.tgz" "$dir$direccioncomprimir";
	#Aqui elimino la carpeta que se descarga en un principio
        rm -R $dir$direccioncomprimir;
done

#ejemplo del comprimido
#${variable/'textobuscar'/textoreemplazo}




####################################################
#Esto copiara todos los viernes a las 24 horas "medianoche" el backup
#0 23 * * 5
#ssh-keygen -t rsa
#ssh-copy-id -i ~/.ssh/id_rsa.pub seead@10.10.10.19