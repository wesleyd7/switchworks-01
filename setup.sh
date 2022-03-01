#!/bin/bash
GREEN="\033[0;32m"
NC="\033[0m" # No Color
printf "I ${RED}love${NC} Stack Overflow\n"


printf "${GREEN}Running apt update${NC}"
sudo apt update
printf "${GREEN}Running apt upgrade${NC}"
sudo apt upgrade -y
printf "${GREEN}Downloading Docker install script${NC}"
curl -fsSL https://get.docker.com -o get-docker.sh
printf "${GREEN}Installing Docker${NC}"
sudo sh get-docker.sh
printf "${GREEN}Setting up environmental variables${NC}"
printf "${GREEN}Please enter your S3_ID: ${NC}"
read -p "${GREEN}S3_ID:${NC}" ID
printf "${GREEN}Please enter your S3_KEY: ${NC}"
read -p "${GREEN}S3_KEY: ${NC}" KEY
printf S3_ID=$ID >> /etc/environment
printf S3_KEY=$KEY >> /etc/environment
printf "${GREEN}moving files and creating directories${NC}"
cp vault.sh ~/
cp keepalive.sh ~/
chmod u+x ~/vault.sh
chmod u+x ~/keepalive.sh
cp testFile ~/
mkdir ~/data
mkdir ~/downloads
printf "${GREEN}setting up cronjobs${NC}"
crontab -l > vault
echo "0 * * * * /bin/bash ~/vault.sh" >> vault
crontab vault
rm vault
crontab -l > keepalive
echo "0-59 * * * * /bin/bash ~/ping.sh" >> keepalive
crontab keepalive
rm keepalive
printf "${GREEN}rebooting in 10 seconds${NC}"
sleep 10
sudo shutdown -r now
