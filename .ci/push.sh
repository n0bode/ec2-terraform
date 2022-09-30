apt update -y
apt install -y python3 python3-pip git

git clone https://github.com/n0bode/ec2-terraform.git

cd ec2-terraform

pip3 install -r requirements.txt
uvicorn --port 80 app:app
