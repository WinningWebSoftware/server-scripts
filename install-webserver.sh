#!/usr/bin/env bash
if [[ $1 == '' || $2 == '' ]]
then
  printf "Please provide: domainName emailAddress \n"
  exit;
fi

sudo apt update
sudo apt install nginx php8.1-fpm php-cli unzip git composer nodejs npm php-curl php-gd -y
sudo ufw allow 'Nginx Full'

sudo bash -c "curl https://raw.githubusercontent.com/WinningWebSoftware/server-scripts/main/webserver.conf > /etc/nginx/sites-available/$1"
sudo sed -i "s/domain.com/$1/" /etc/nginx/sites-available/"$1"

sudo ln -s /etc/nginx/sites-available/"$1" /etx/nginx/sites-enabled/

sudo unlink /etc/nginx/sites-enabled/default

sudo chown -R $USER:$USER /var/www
sudo mkdir -p /var/www/"$1"/public

echo '<h1>Welcome to your Nginx webserver!</h1><p>Delete this file and get started!</p>' > /var/www/"$1"/public/index.php

sudo snap install core
sudo snap refresh core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo certbot --nginx --non-interactive -m "$2" -d "$1"

ssh-keygen
sudo npm cache clean -f
sudo npm install -g n -y
sudo n stable

echo -e "Setup complete!\n"