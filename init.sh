#!/bin/bash
export current_ip="$(hostname -I |awk '{ print $1 }')"
cp /home/ansible/ansible/local_inventory /home/ansible/ansible/local_inventory_bck
sed -i "s/127\.0\.0\.1/$current_ip/" /home/ansible/ansible/local_inventory

sudo docker run \
    -v ${PWD}:/ansible \
    willhallonline/ansible:2.10 \
    ansible-playbook -i local_inventory install.yml --extra-vars "for_user=$USER"

sudo docker run \
    -v ${PWD}:/ansible \
    willhallonline/ansible:2.10 \
    ansible-playbook -i local_inventory post_java_install.yml --extra-vars "for_user=$USER"

touch /home/ansible/.initialized
# dejamos el fichero como estaba
mv /home/ansible/ansible/local_inventory_bck /home/ansible/ansible/local_inventory

