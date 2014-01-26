#!/bin/sh

res='fail'

module_name='fever'
. /raid/data/tmp/module/System/lib/libsys
ret=`etc_backup "$module_name"`

mkdir "/raid/data/module/cfg/" 		> /dev/null 2>&1
mkdir "/raid/data/module/cfg/module.rc/" 	> /dev/null 2>&1
mkdir "/raid/data/module/$module_name/" 	> /dev/null 2>&1
mkdir "/raid/data/module/$module_name/bin/" 	> /dev/null 2>&1
mkdir "/raid/data/module/$module_name/shell/" 	> /dev/null 2>&1
mkdir "/raid/data/module/$module_name/sys/" 	> /dev/null 2>&1
mkdir "/raid/data/module/$module_name/www/" 	> /dev/null 2>&1
mkdir "/raid/data/module/$module_name/drv/"	> /dev/null 2>&1

cp -f 	/raid/data/tmp/module/Shell/module.rc		"/raid/data/module/cfg/module.rc/$module_name.rc" 	> /dev/null 2>&1
cp -rf 	/raid/data/tmp/module/Binary/* 			"/raid/data/module/$module_name/bin"			> /dev/null 2>&1
cp -rf 	/raid/data/tmp/module/Shell/* 			"/raid/data/module/$module_name/shell"			> /dev/null 2>&1
cp -rf 	/raid/data/tmp/module/System/* 			"/raid/data/module/$module_name/sys"			> /dev/null 2>&1
cp -rf 	/raid/data/tmp/module/WWW/*			"/raid/data/module/$module_name/www"			> /dev/null 2>&1
cp -rf	/raid/data/tmp/module/Driver/*			"/raid/data/module/$module_name/drv"
cp -f 	/raid/data/tmp/module/Configure/license.txt	"/raid/data/module/$module_name/COPY"			> /dev/null 2>&1

set_msg_log "$module_name" "Creating SSL Certificate"

/raid/data/module/apache/sys/bin/openssl req -new -x509 -days 3650 -nodes -utf8 -out /raid/data/module/fever/bin/fever.crt -keyout /raid/data/module/fever/bin/fever.key -subj '/C=FR/ST="Thecus Land"/L="NAS City"/O=Realityloop/OU="Third Party dev Team" Name/CN=www.thecus.com'

set_msg_log "$module_name" "done"

set_msg_log "$module_name" "Fever"
set_msg_log "$module_name" "Rock N Roll"
set_event "$module_name" "1001" "info" "no"
ret=`create_module_folder "fever"`

res='pass'

echo $res
