#!/bin/bash
#wget https://raw.githubusercontent.com/daniel-alonso-sanchez/debian-ansible-preseed/ad/mkhomedir -O /usr/share/pam-configs/mkhomedir 
#wget https://raw.githubusercontent.com/daniel-alonso-sanchez/debian-ansible-preseed/ad/ad-connect -O /etc/init.d/ad-connect 
chmod +x /etc/init.d/ad-connect
update-rc.d ad-connect defaults
