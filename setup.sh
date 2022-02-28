#!/bin/bash
echo 'Running apt update'
sudo apt update
echo 'Running apt upgrade'
sudo apt upgrade -y
echo 'Downloading Docker install script'
curl -fsSL https://get.docker.com -o get-docker.sh
echo 'Installing Docker'
sudo sh get-docker.sh
echo 'Setting up environmental variables'
echo 'Please enter your S3_ID: '
read -p 'S3_ID:' ID
echo 'Please enter your S3_KEY: '
read -p 'S3_KEY: ' KEY
echo S3_ID=$ID >> /etc/environment
echo S3_KEY=$KEY >> /etc/environment
echo 'moving files and creating directories'
cp vault.sh /home/debian/
cp keepalive /home/debian/
cp testFile /home/debian/
mkdir /home/debian/data
mkdir /home/debian/downloads
echo 'setting up cronjobs'
crontab -l > vault
echo '5,10,15,20,25,30,35,40,45,50,55 * * * * /bin/bash /home/debian/vault.sh' >> vault
crontab vault
rm vault
crontab -l > keepalive
echo '0-59 * * * * /bin/bash /home/debian/ping.sh' >> keepalive
crontab keepalive
rm keepalive
echo 'rebooting in 10 seconds'
sleep 10
sudo shutdown -r now
