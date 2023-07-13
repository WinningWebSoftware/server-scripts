#!/usr/bin/env bash
if [[ $1 == '' ]]
then
  echo "Error: Please enter a name for your new sudo user."
  exit
fi

apt-get update -y

adduser --disabled-password --gecos "" --quiet "$1"
usermod -aG sudo "$1"

rsync --archive --chown="$1":"$1" ~/.ssh /home/"$1"

sudo ufw --force enable
ufw allow OpenSSH