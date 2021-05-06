#!/bin/bash
wget https://raw.githubusercontent.com/daniel-alonso-sanchez/debian-ansible-preseed/master/mkhomedir -O /usr/share/pam-configs/mkhomedir 
export PATH=$PATH:/usr/sbincat > /etc/init.d/ad-connect <<EOL
#! /bin/bash
### BEGIN INIT INFO
# Provides:       my-start-script
# Required-Start:    \$local_fs \$syslog
# Required-Stop:     \$local_fs \$syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts my-start-script
# Description:       starts my-start-script using start-stop-daemon
### END INIT INFO

exec > /root/logfile.txt 2>&1
AD_USER=`cat /root/ad_user`
AD_DOMAIN=`cat /root/ad_domain`
cat /root/ad_cred| realm join -U $AD_USER $AD_DOMAIN
pam-auth-update --enable mkhomedir
sed -i 's|use_fully_qualified_names = True|use_fully_qualified_names = False|g' /etc/sssd/sssd.conf
sed -i 's|/home/%u@%d|/home/%u|g' /etc/sssd/sssd.conf
systemctl restart sssd


exit 0
EOL
chmod 755 /etc/init.d/ad-connect
update-rc.d ad-connect defaults
