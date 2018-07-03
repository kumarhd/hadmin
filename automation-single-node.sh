#!/bin/sh
yum install git wget -y
wget https://mirror.its.sfu.ca/mirror/CentOS-Third-Party/NSG/common/x86_64/jdk-8u102-linux-x64.rpm
rpm -ivh jdk-8u102-linux-x64.rpm
echo "export JAVA_HOME=/usr/java/default" >> /etc/profile
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> /etc/profile
source /etc/profile
wget https://archive.apache.org/dist/hadoop/core/hadoop-1.2.1/hadoop-1.2.1.tar.gz
mkdir -p /usr/hadoop/namenode /usr/hadoop/datanode /usr/hadoop/tmp /var/log/hadoop
tar -zxvf hadoop-1.2.1.tar.gz -C /usr/hadoop/
git clone https://github.com/kumarhd/hadmin.git
cd hadmin
sed -i 's/EC2HOSTNAME/'`hostname -f`'/g' core-site.xml
sed -i 's/EC2HOSTNAME/'`hostname -f`'/g' mapred-site.xml
cp core-site.xml /usr/hadoop/hadoop-1.2.1/conf/
cp mapred-site.xml /usr/hadoop/hadoop-1.2.1/conf/
echo "export JAVA_HOME=/usr/java/default" >> /usr/hadoop/hadoop-1.2.1/conf/hadoop-env.sh
echo "export HADOOP_LOG_DIR=/var/log/hadoop" >> /usr/hadoop/hadoop-1.2.1/conf/hadoop-env.sh
echo `hostname -f` > /usr/hadoop/hadoop-1.2.1/conf/masters
echo `hostname -f` > /usr/hadoop/hadoop-1.2.1/conf/slaves
echo "export HADOOP_HOME=/usr/hadoop/hadoop-1.2.1/" >> /etc/profile
echo "export PATH=\$PATH:\$HADOOP_HOME/bin" >> /etc/profile
source /etc/profile
groupadd hadoop
useradd -g hadoop hdfs
chown -R hdfs:hadoop /usr/hadoop /var/log/hadoop

#DO THIS MANUALLY
#cd ~
#ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''
#cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys
#ssh -o "StrictHostKeyChecking no" `hostname` 'date'
