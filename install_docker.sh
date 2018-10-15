#!/usr/bin/env bash
# Installs Docker Community Edition on Ubuntu platform

# Alex Coleman
# 2018/10/02

echo "Installing Docker..."

# Get Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "Official Key: 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88"
sudo apt-key fingerprint | grep -A 1 0EBFCD88

# Add the Official Docker Repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update

# Install Docker
sudo apt-get install docker-ce

# Add current user to the docker group
sudo groupadd docker
# sudo usermod -aG docker $USER # USER must relog to see this change

# For Ubuntu 14.10 and below, docker is automatically configured to run at start
# For Ubuntu 16.04 and higher, run the following to auto start docker on boot up
# sudo systemctl enable docker

# Test docker install
# sudo docker run hello-world
