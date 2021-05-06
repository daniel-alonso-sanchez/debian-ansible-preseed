#!/bin/bash
wget https://raw.githubusercontent.com/daniel-alonso-sanchez/debian-ansible-preseed/master/mkhomedir -O /usr/share/pam-configs/mkhomedir 
pam-auth-update --enable mkhomedir
sed -i 's|use_fully_qualified_names = True|use_fully_qualified_names = False|g' /etc/sssd/sssd.conf
sed -i 's|/home/%u@%d|/home/%u|g' /etc/sssd/sssd.conf
