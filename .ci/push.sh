#! /bin/bash
sudo apt-get update -y
sudo apt-get install -y python3 python3-pip git
echo "ok" > /home/ubuntu/ok
cd /home/ubuntu
git clone https://github.com/n0bode/ec2-terraform.git
cd ec2-terraform
sudo pip3 install -r requirements.txt
sudo chmod +x service.sh
sudo ./service.sh