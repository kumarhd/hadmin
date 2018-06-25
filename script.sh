#!/bin/sh
passwd root <<EOF
hadoophdp
hadoophdp
EOF
yum install bind-utils httpd wget firewalld  -y --nogpgcheck
echo "127.0.0.1 localhost.localdomain localhost" > /etc/hosts
echo "127.0.0.1 localhost4.localdomain4 localhost4" >> /etc/hosts
cd ~
ip a | grep inet | grep eth0 | awk '{ print $2}' | tr "/" " " | awk '{ print $1}' | head -n 1 > ipaddr
hostname -f | tr "." " " | awk '{ print $1}' > hname
hostname -f > fqdn
cat ipaddr fqdn hname | xargs >> /etc/hosts
service httpd start
systemctl enable httpd
service firewalld stop
systemctl disable firewalld
wget https://mirror.its.sfu.ca/mirror/CentOS-Third-Party/NSG/common/x86_64/jdk-8u144-linux-x64.rpm
