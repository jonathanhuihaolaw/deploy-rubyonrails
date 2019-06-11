#!/bin/bash

installSSL(){
 sudo apt install certbot python-certbot-apache -t stretch-backports -y -qq
 sudo certonly --standalone
 sudo echo "@reboot /bin/bash -l -c 'cd /srv/www && sudo rails s -p 443 -b \"ssl://0.0.0.0?key=/etc/letsencrypt/live/[DOMAIN_NAME]/privkey.pem&cert=/etc/letsencrypt/live/[DOMAIN_NAME]/fullchain.pem\"'" >> startcron
 sudo crontab startcron
 sudo rm startcron
 sudo apt autoremove
 sudo rm -rf /var/apache2
}

echo "Setting up required packages for Ruby on Rails"
echo "Creating directory for hosting at /srv/www"
sudo mkdir /srv/www
echo "Installing Git"
sudo apt install git -y -qq
echo "Installing NodeJS"
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt install nodejs -y -qq
echo "Installing Ruby"
sudo apt install ruby-full -y -qq
echo "Installing build-packages for bulding rails"
sudo apt install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev curl git-core libpq-dev -y -qq
sudo apt install libsqlite3-dev -y -qq
echo "gem: --no-document" > ~/.gemrc
echo "Installing gem bundler"
sudo gem install bundler
echo "Installing Rails 4.2.1"
echo "This process will take longer than usual"
sudo gem install rails -v 4.2.1
echo "Now, let rails serve public traffic on reboot"
echo "Setting to start HTTP server at /srv/www/"
sudo echo "@reboot /bin/bash -l -c 'cd /srv/www && sudo rails s -p 80 -b 0.0.0.0'" >> startcron
sudo crontab startcron
sudo rm startcron
echo -e "Installation done"
echo " - "

while true; do
    read -p "Do you want to setup SSL? y/n " yn
    case $yn in
        [Yy]* ) installSSL; break;;
        [Nn]* ) exit;;
        * ) echo -e "Please answer y or n.";;
    esac
done
