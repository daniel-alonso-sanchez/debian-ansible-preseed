#!/bin/bash
export PATH=$PATH:/usr/sbin
exec > /root/logfile.txt 2>&1
cat /root/ad_cred| realm join -U admin365 riskms.es
wget https://raw.githubusercontent.com/daniel-alonso-sanchez/debian-ansible-preseed/master/mkhomedir -O /usr/share/pam-configs/mkhomedir 
pam-auth-update --enable mkhomedir
sed -i 's|use_fully_qualified_names = True|use_fully_qualified_names = False|g' /etc/sssd/sssd.conf
sed -i 's|/home/%u@%d|/home/%u|g' /etc/sssd/sssd.conf
systemctl restart sssd
