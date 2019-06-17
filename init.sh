#!/bin/bash
sudo apt-get update -y

# ref: https://www.vultr.com/docs/how-to-install-apache-cassandra-3-11-x-on-ubuntu-16-04-lts

# Install Java
sudo apt install openjdk-8-jre -y

# Set JAVA_HOME
echo "JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")" | sudo tee -a /etc/profile
source /etc/profile
echo $JAVA_HOME

# Install Python2
sudo apt install python -y

# Install Cassandra
echo "deb http://www.apache.org/dist/cassandra/debian 311x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
curl https://www.apache.org/dist/cassandra/KEYS | sudo apt-key add -
sudo apt-get update -y
sudo apt-get install -y cassandra

# Test the installation of Cassandra
sudo service cassandra start

# Open a port
# TCP port for commands and data.
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 7000 -j ACCEPT
# TCP port for the native transport server. cqlsh, the Cassandra command line utility, will connect to the cluster through this port.
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 9042 -j ACCEPT
# ????
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 7199 -j ACCEPT

# Set cluster confgration
cp /vagrant/cassandra.yaml /etc/cassandra/cassandra.yaml
export ETCD_HOST_IP=$(ip addr show enp0s8 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
sudo sed -i "s/ETCD_HOST_IP/${ETCD_HOST_IP}/g" /etc/cassandra/cassandra.yaml
sudo service cassandra restart
