#!/bin/bash
#Usuario mysql
myuser=root
mypass=password

#Carpeta donde se respaldara
primera=/BaseDeDatos/*
dir=/BaseDeDatos/RespaldoBD_`date '+%Y%m%d'`

#Aqui borro los archivos o carpetas viejos de los respaldos viejos, tengo que cambiar el 0 por 3 para que te$
find $primera -type d -mtime +4 -exec rm -R {} \;

#aqui creo la carpeta
mkdir -p $dir;

args="-u"$myuser" -p"$mypass" --add-drop-database --add-locks --create-options --complete-insert --comments  --disable-keys --dump-date --extended-insert --quick --routines --triggers"

mysql -u$myuser -p$mypass -e 'show databases' | grep -Ev "(Database|information_schema)" > $dir/databases.list

echo "Se volcarán las siguientes bases de datos:"
mysql -u$myuser -p$mypass -e 'select table_schema "DATABASE",convert(sum(data_length+index_length)/1048576,  decimal(6,2)) "SIZE (MB)" from information_schema.tables where table_schema!="information_schema" group by table_schema;'
CONT=1
while read DB
do
        dump=$dir/"dump_"$DB".sql"
        echo -n $dump"... "
        mysqldump ${args} $DB > $dump
        echo "OK."
done < $dir/databases.list