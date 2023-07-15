#!/usr/bin/env bash
if [[ $1 == "" || $2 == "" ]]
then
  echo -e "Please provide your domain name (without http/https) and your email address (for SSL expiration emails).\n"
  exit
fi

echo -e "Installing Java Runtime Environment and Java Dev Kit\n"
sudo apt install default-jre default-jdk -y

echo -e "Downloading Jenkins and saving keys\n"
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo -e "Updating package list\n"
sudo apt-get update -y

echo -e "Installing Jenkins\n"
sudo apt-get install jenkins -y
sudo ufw allow 8080

echo -e "Installing Nginx\n"
sudo apt install nginx -y

echo -e "Allowing Nginx through the firewall\n"
sudo ufw allow 'Nginx Full'

echo -e "Fetching server config file\n"
sudo bash -c "curl https://raw.githubusercontent.com/WinningWebSoftware/server-scripts/main/jenkins.conf > /etc/nginx/sites-available/$1"
sudo sed "s/domain.com/$1/" /etc/nginx/sites-available/"$1"

sudo mkdir -p /var/www/"$1"/html
sudo chown -R $USER:$USER /var/www/"$1"/html
sudo chmod -R 755 /var/www/"$1"

sudo ln -s /etc/nginx/sites-available/"$1" /etc/nginx/sites-enabled/
sudo unlink /etc/nginx/sites-enabled/default

sudo sed "s/JENKINS_ARGS=\"--webroot=\/var\/cache\/\$NAME/war --httpPort=\$HTTP_PORT/JENKINS_ARGS=\"--webroot=\/var\/cache\/\$NAME/war --httpPort=\$HTTP_PORT --httpListenAddress=127.0.0.1/" /etc/default/jenkins

sudo snap install core
sudo snap refresh core
sudo snap install --classic --non-interactive --agree-tos -m "$2" certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo certbot --nginx -d "$1"

sudo systemctl reload nginx

echo -e "Jenkins installed and available on port 8080. Initial admin password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword