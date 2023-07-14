#!/usr/bin/env bash
if [[ $1 == '' ]]
then
  echo -e "Error: Please provide a name for your new sudo user."
  exit
fi

echo -e "Updating package list"
apt-get update -y

echo -e "Creating new user with username $1"
adduser --disabled-password --gecos "" --quiet "$1"

echo -e "Granting sudo privileges to $1"
usermod -aG sudo "$1"
rsync --archive --chown="$1":"$1" ~/.ssh /home/"$1"

echo -e "Enabling firewall"
sudo ufw --force enable

echo -e "Allowing OpenSSH"
ufw allow OpenSSH

echo "User created, please exit your server and connect again with $1"