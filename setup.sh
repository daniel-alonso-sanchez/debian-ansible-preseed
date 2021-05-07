#!/bin/bash
exec > '/home/ansible/.customization.log'
cd "$(dirname "$0")"
if [ -e /home/ansible/.initialized ]
then
    echo 'No steps required'
else
    echo 'Iniciando personalizacion de iso'
    #zenity --info --title="Inicio de personalizacion" --text="Iniciando personalizacion con ansible" --timeout 5
    sh init.sh
    #zenity --info --title="Fin personalizacion" --text="Personalizacion finalizada" --timeout=5
fi
