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