Name:		startup
Version: 	0.1
Release:	1%{?dist}
Summary: 	A collection of configuration changes

Group:		NTI-320
License:	GPL2+
URL:		https://github.com/nic-instruction/hello-NTI-320
Source0:        https://github.com/nic-instruction/hello-NTI-320/startup-0.1.tar.gz

BuildRequires:	gcc, python >= 1.3
Requires:	bash, net-snmp, net-snmp-utils, nrpe, nagios-plugins-all

%description
This package contains customization for a monitoring server, a trending server and a   logserver on the nti320 network.

%prep
%setup -q	
		
%build					
%define _unpackaged_files_terminate_build 0

%install

rm -rf %{buildroot}
mkdir -p %{buildroot}/usr/lib64/nagios/plugins/
mkdir -p %{buildroot}/etc/nrpe.d/

install -m 0755 nti-sanity.sh %{buildroot}/usr/lib64/nagios/plugins/

install -m 0744 nti320.cfg %{buildroot}/etc/nrpe.d/

%clean

%files					
%defattr(-,root,root)	
/usr/lib64/nagios/plugins/nti-sanity.sh


%config
/etc/nrpe.d/nti320.cfg

%doc			



%post

touch /thisworked
systemctl enable snmpd
systemctl start snmpd
sed -i 's,/dev/hda1,/dev/sda1,'  /etc/nagios/nrpe.cfg

cp /etc/nagios/nrpe.cfg /etc/nagios/nrpe.cfg.bak
sed -i 's/allowed_hosts=127.0.0.1/allowed_hosts=127.0.0.1, $nrpeip/g' /etc/nagios/nrpe.cfg

systemctl restart nagios-nrpe-server

yum -y install net-tools

sed -i 's/#$ModLoad imudp/$ModLoad imudp/g' /etc/rsyslog.conf
sed -i 's/#$UDPServerRun 514/$UDPServerRun 514/g' /etc/rsyslog.conf
sed -i 's/#$ModLoad imtcp/$ModLoad imtcp/g' /etc/rsyslog.conf
sed -i 's/#$InputTCPServerRun 514/$InputTCPServerRun 514/g' /etc/rsyslog.conf

systemctl restart rsyslog.service

echo "*.info;mail.none;authpriv.none;cron.none   @$rsyslogip" >> /etc/rsyslog.conf && systemctl restart rsyslog.service

%postun
rm /thisworked
rm /etc/nrpe.d/nti320.cfg
%changelog				# changes you (and others) have made and why
