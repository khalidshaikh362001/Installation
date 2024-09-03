## Install Docker Runtime
sudo apt update -y
sudo apt install docker.io -y

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

sudo systemctl start docker
sudo systemctl enable docker