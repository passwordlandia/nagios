#!/bin/bash

yum -y install net-snmp

systemctl enable snmpd
systemctl start snmpd

yum -y install net-snmp-utils

snmpwalk -v 1 -c public -O e 127.0.0.1
