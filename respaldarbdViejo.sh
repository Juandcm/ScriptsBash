#!/bin/bash
#Configuración de variables de entorno
MYSQL='/usr/bin/mysql'
MYSQLDUMP='/usr/bin/mysqldump'
DUMPOPTS='--opt --hex-blob --add-locks --create-options --complete-insert --comments --dump-date --extended-insert --quick --routines --triggers'
DATEFORMAT='%Y-%m-%d'  # See man date

#Antes de hacer cualquier cambio tengo que crear una carpeta en el server con el nombre Respaldosbd que puede estar guardada en el home
#configuración de usuario, clave y directorio
user='root'
pass='labase!2011_0'
#Aqui va a ir la direccion donde se guardara las bd
primera=/Respaldosbd/*
dir=/Respaldosbd/RespaldoBD_`date '+%Y%m%d'`

#Aqui borro los archivos o carpetas viejos de los respaldos viejos, tengo que cambiar el 0 por 3 para que tenga una antiguedad de 3 dias
find $primera -type d -mtime +4 -exec rm -R {} \;

mkdir -p $dir;


while getopts 'u:d:p:h' OPTION
do
    case $OPTION in
        u)
            user="$OPTARG"
            ;;
        d)
            dir="$OPTARG"
            ;;
        p)
            pass="$OPTARG"
            ;;
        h|?)
            printf  "Usage: %s: [-u USER] [-p PASSWORD] [-d DIRECTORY]\n" \
                $(basename $0) >&2
            exit 2
            ;;
    esac
done
if [ -z "$pass" ]
then
    read -s -p "password: " pass ; printf "%b" "\n"
fi

#Se obtienen los nombre de las bases de datos
##Con contraseña
##databases=`$MYSQL -u$user -p$pass --skip-column-names -e'SHOW DATABASES'`

#Sin contraseña
#databases=`$MYSQL -u$user --skip-column-names -e'SHOW DATABASES'`

# Array para seleccionar las bd a guardar
databases=(
"bugtracker"
"censo"
"censoplan"
"chamilo"
"chat"
"ciencias_sociales"
"cloud_9"
"comunitario2012"
"congreso"
"enlace"
"estudiante"
"extension"
"formacion2012"
"guia"
"introductorio"
"introductorioead"
"juvineu"
"laboratorio"
"laboratorio2"
"laboratorioextension"
"mgpc"
"notas"
"opei"
"pfevea"
"pnat"
"portal_nuevo"
"portal_wordpress"
"portalseead"
"postgrado"
"pregrado"
"pregrado2"
"sedic"
"serviciocomunitario"
"sistema_inscripcion"
"turismo"
"vpa"
"vpdr"
"vpds"
)

# Se escribe un archivo comprimido del respaldo de cada base de datos y organizándolos por fecha de ejecución del respaldo
for db in "${databases[@]}"; do
    filename=`date +"$dir/$db-$DATEFORMAT.sql.gz"`
    #echo "creating $filename"
    echo "Guardando la BD: "$db
##Con contraseña
#$MYSQLDUMP $DUMPOPTS -u$user -p$pass $db \

##Sin contraseña
    $MYSQLDUMP $DUMPOPTS -u$user -p$pass $db \
        | gzip -9 > $filename

done

####################################################
#Esto copiara todos los viernes a las 24 horas "medianoche" el backup
#0 23 * * 5

