#!/bin/bash -e
folder=/home/ubuntu/webapp
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo git clone https://github.com/viva2021/webapp.git $folder
sudo apt update && sudo apt full-upgrade -y
sudo apt-get install git -y
curl -sL https://deb.nodesourse.com/setup_16.x | sudo -E bash -
sudo apt install nodejs -y
sudo apt install npm -y
sudo apt install nginx -y
sudo npm install pm2 -g -y
cd /home/ubuntu/webapp
sudo npm install
sudo npm install esm
sudo pm2 start index.js --node-args="-r esm"
sudo cp default /etc/nginx/sites-available/ -f
sleep 10
sudo service nginx start
sleep 10
sudo service nginx restart