#!/bin/bash

yum -y install cacti
yum -y install mariadb-server
yum install -y php-process php-gd php mod_php -y

systemctl enable mariadb
systemctl enable httpd
systemctl enable snmpd

systemctl start mariadb
systemctl start httpd
systemctl start snmpd

setenforce 0

mysqladmin -u root password c@ctii

mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root -pc@ctii mysql

echo "create database cacti;
GRANT ALL ON cacti.* TO cacti@localhost IDENTIFIED BY 'c@ctii';  
FLUSH privileges;

GRANT SELECT ON mysql.time_zone_name TO cacti@localhost;           
FLUSH privileges;" > stuff.sql


mysql -u root -pc@ctii < stuff.sql
rpm -ql cacti|grep cacti.sql
mysql -u cacti -pc@ctii cacti < /usr/share/doc/cacti-1.1.37/cacti.sql

sed -i 's/Require host localhost/Require all granted/' /etc/httpd/conf.d/cacti.conf
sed -i 's/Allow from localhost/Allow from all all/' /etc/httpd/conf.d/cacti.conf

sed -i "s/\$database_username = 'cactiuser';/\$database_username = 'cacti';/" /etc/cacti/db.php
sed -i "s/\$database_password = 'cactiuser';/\$database_password = 'c@ctii';/" /etc/cacti/db.php

systemctl restart httpd

sed -i 's/#//g' /etc/cron.d/cacti

cp /etc/php.ini /etc/php.ini.orig
sed -i 's/;date.timezone =/date.timezone = America\/Regina/' /etc/php.ini

setenforce 0


systemctl restart httpd
echo "[nti-320]
name=Extra Packages for Centos from NTI-320 7 - $basearch
#baseurl=http://download.fedoraproject.org/pub/epel/7/$basearch <- example epel repo
# Note, this is putting repodata at packages instead of 7 and our path is a hack around that.
baseurl=http://10.142.0.2/centos/7/extras/x86_64/Packages/
enabled=1
gpgcheck=0
" >> /etc/yum.repos.d/NTI-320.repo
