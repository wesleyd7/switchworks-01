#!/bin/bash

echo "Running apt update"
sudo apt update
echo "Running apt upgrade"
sudo apt upgrade -y
echo "Downloading Docker install script"
curl -fsSL https://get.docker.com -o get-docker.sh
echo "Installing Docker"
sudo sh get-docker.sh
echo "Setting up environmental variables"
echo "Please enter your S3_ID: "
read -p "S3_ID:" ID
echo "Please enter your S3_KEY: "
read -p "S3_KEY: " KEY
echo S3_ID=$ID >> /etc/environment
echo S3_KEY=$KEY >> /etc/environment
echo "moving files and creating directories"
cp vault.sh ~/
cp keepalive.sh ~/
chmod u+x ~/vault.sh
chmod u+x ~/keepalive.sh
cp testFile ~/
mkdir ~/data
mkdir ~/downloads
echo "setting up cronjobs"
crontab -l > vault
echo "0 * * * * /bin/bash ~/vault.sh" >> vault
crontab vault
rm vault
crontab -l > keepalive
echo "0-59 * * * * /bin/bash ~/ping.sh" >> keepalive
crontab keepalive
rm keepalive
echo "rebooting in 10 seconds"
sleep 10
sudo shutdown -r now
