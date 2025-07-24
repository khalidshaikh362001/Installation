#!/bin/bash

# Update the Debian apt repositories, install OpenJDK 17, and check the installation
sudo apt update
sudo apt install fontconfig openjdk-17-jre -y
java -version

# Long Term Support release
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y

# enable the Jenkins service
sudo systemctl enable jenkins

# start the Jenkins service
sudo systemctl start jenkins

# print the password at console.
sudo cat /var/lib/jenkins/secrets/initialAdminPassword


#improvement - output of password 
# can generate the link for jenkins 
