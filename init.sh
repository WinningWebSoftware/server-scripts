#!/usr/bin/env bash
if [[ $1 == '' ]]
then
  echo "Error: Please enter a name for your new sudo user."
  exit
fi

echo "Updating package index"
apt-get update -y

echo "Creating user"
adduser --disabled-password --gecos "" --quiet "$1"

echo "User $1 created. Granting sudo privileges"
usermod -aG sudo "$1"

rsync --archive --chown="$1":"$1" ~/.ssh /home/"$1"

echo "Enabling Firewall and allowing OpenSSH"
sudo ufw --force enable
ufw allow OpenSSH