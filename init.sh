#!/bin/bash
cd /home/ansible/ansible
export current_ip="$(hostname -I |awk '{ print $1 }')"
cp /home/ansible/ansible/local_inventory /home/ansible/ansible/local_inventory_bck
git checkout -- .
git checkout -b ad origin/ad
sed -i "s/127\.0\.0\.1/$current_ip/" /home/ansible/ansible/local_inventory
sed -i "s/$/ ansible_ssh_common_args='-o StrictHostKeyChecking=no'/" /home/ansible/ansible/local_inventory

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

