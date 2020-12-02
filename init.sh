#!/bin/bash
export current_ip="$(hostname -I |awk '{ print $1 }')"
cp /home/usuario/ansible/local_inventory /home/usuario/ansible/local_inventory_bck
sed -i "s/127\.0\.0\.1/$current_ip/" /home/usuario/ansible/local_inventory
echo "Building ansible docker image"
docker build . -t ansibled  
echo "Running ansible customization"
docker run -v /home/usuario/ansible:/ansible/playbooks ansibled install.yml -i local_inventory
docker run -v /home/usuario/ansible:/ansible/playbooks ansibled post_java_install.yml -i local_inventory

touch /home/usuario/.initialized
# dejamos el fichero como estaba
mv /home/usuario/ansible/local_inventory_bck /home/usuario/ansible/local_inventory

