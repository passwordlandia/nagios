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

echo "[nti-320]
name=Extra Packages for Centos from NTI-320 7 - $basearch
#baseurl=http://download.fedoraproject.org/pub/epel/7/$basearch <- example epel repo
# Note, this is putting repodata at packages instead of 7 and our path is a hack around that.
baseurl=http://10.142.0.19/centos/7/extras/x86_64/Packages/
enabled=1
gpgcheck=0
" >> /etc/yum.repos.d/NTI-320.repo 
