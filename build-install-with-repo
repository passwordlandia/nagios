#!/bin/bash

yum -y install rpm-build make gcc git                                        
mkdir -p /root/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}                     
                                                                              
cd ~/
echo '%_topdir %(echo $HOME)/rpmbuild' > ~/.rpmmacros                        
cd ~/rpmbuild/SOURCES
git clone https://github.com/NagiosEnterprises/nrpe.git                     
git clone https://github.com/NagiosEnterprises/nagioscore.git                

tar -czvf nrpe-3.1.tar.gz /root/rpmbuild/SOURCES/nrpe                        
tar -czvf nagioscore-4.3.1.tar.gz /root/rpmbuild/SOURCES/nagioscore          

mv nagioscore nagioscore-4.3.1                                                
mv nrpe nrpe-3.1                                                             
mkdir nagioscore                                                              
mkdir nrpe
mv nagioscore-4.3.1 nagioscore
mv nrpe-3.1 nrpe

cd ../SPECS                                                                  
cp /usr/share/vim/vimfiles/template.spec .

echo "[nti-320]
name=Extra Packages for Centos from NTI-320 7 - $basearch
#baseurl=http://download.fedoraproject.org/pub/epel/7/$basearch <- example epel repo
# Note, this is putting repodata at packages instead of 7 and our path is a hack around that.
baseurl=http://10.142.0.19/centos/7/extras/x86_64/Packages/
enabled=1
gpgcheck=0
" >> /etc/yum.repos.d/NTI-320.repo 
