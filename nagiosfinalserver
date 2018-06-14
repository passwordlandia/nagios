#!/bin/bash

yum -y install nagios

systemctl enable nagios
systemctl start nagios

setenforce 0

yum install -y httpd
systemctl enable httpd
systemctl start httpd

yum install nagios-plugins-all
yum install -y nagios-plugins-nrpe

yum install -y nrpe
systemctl enable nrpe
systemctl start nrpe

htpasswd -c /etc/nagios/passwd nagiosadmin

#then type in password#

echo '########### NRPE CONFIG LINE #######################
define command{
command_name check_nrpe
command_line $USER1$/check_nrpe -H $HOSTADDRESS$ -c $ARG1$
}' >> /etc/nagios/objects/commands.cfg
