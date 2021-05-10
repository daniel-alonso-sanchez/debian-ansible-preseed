#!/bin/bash
export current_ip="$(hostname -I |awk '{ print $1 }')"
cp /home/ansible/ansible/local_inventory /home/ansible/ansible/local_inventory_bck
sed -i "s/127\.0\.0\.1/$current_ip/" /home/ansible/ansible/local_inventory

docker run \
    -v ${PWD}:/ansible \
    willhallonline/ansible:2.9-alpine \
    ansible-playbook -i local_inventory install.yml

docker run \
    -v ${PWD}:/ansible \
    willhallonline/ansible:2.9-alpine \
    ansible-playbook -i local_inventory post_java_install.yml

touch /home/ansible/.initialized
# dejamos el fichero como estaba
mv /home/ansible/ansible/local_inventory_bck /home/ansible/ansible/local_inventory

