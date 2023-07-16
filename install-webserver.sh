#!/usr/bin/env bash
if [[ $1 == '' || $2 == '' || $3 == '' ]]
then
  printf "Please provide: domainName emailAddress mysqlUsername\n"
  exit;
fi

sudo apt update
sudo apt install nginx php8.1-fpm php-cli unzip -y
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

sudo apt -f install mysql-server -y

mysql_root_password=$(openssl rand -base64 12)
mysql_user_password=$(openssl rand -base64 12)
mysql -u "root" "-p" -Bse "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password by '$mysql_root_password'; CREATE USER '$3'@'%' IDENTIFIED WITH mysql_native_password by '$mysql_user_password'; GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT, REFERENCES, RELOAD on *.* TO '$3'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"

sudo sed -i "s/bind-address/#bind-address/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo mysql_secure_installation
sudo ufw allow from remote_ip_address to any port 3306

ssh-keygen
sudo apt -f install git composer nodejs npm php-curl php-gd -y
sudo npm cache clean -f
sudo npm install -g n -y
sudo n stable

echo -e "Setup complete!\n"
echo -e "MySQL Root Password: $mysql_root_password\n"
echo -e "MySQL Username: $3\n"
echo -e "MySQL User Password: $mysql_user_password\n"