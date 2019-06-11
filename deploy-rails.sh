#!/bin/bash
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
echo "Setting to start HTTP server at /srv/www/*"
sudo echo "@reboot /bin/bash -l -c 'cd /srv/www && sudo rails s -p 80 --binding='0.0.0.0/0'" >> startcron
sudo crontab startcron
sudo rm startcron
