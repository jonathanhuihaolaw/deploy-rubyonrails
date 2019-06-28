# Ruby on Rails deployment script
Deployment script for Ruby on Rails on a Debian/Ubuntu VM

## Getting Started

Setup your machine with either Debian or Ubuntu locally or on Google Cloud. Ensure port 22 and 443 is open.<br>
Optionally, you can choose to enable SSL setup. SSL certificates are provided by CertBot :<br>
[Certbot website](https://certbot.eff.org/about/)<br>
!! Please use sudo as we want to serve on startup. Will create a workaround for that.

### Deployment structure

Hosting directory :
```
/srv/www
```
SSL cert directory :
```
/etc/letsencrypt/live/[DOMAIN_NAME]
```

Server start on boot :
sudo crontab -l
```
@reboot /bin/bash -l -c 'cd /srv/www && sudo rails s -p 80 -b 0.0.0.0'
```

### Installing

1. Fire up terminal / SSH console and run

```
wget https://raw.githubusercontent.com/jonathanhuihaolaw/deploy-rubyonrails/master/deploy-rails.sh && sudo bash ./deploy-rails.sh
```

2. Extract your hosting content into /srv/www/*
    eg. /srv/www/index.html
    
3. Install required GEM dependencies
```
sudo bundle install
```

4. Reboot
```
sudo reboot
```

## SSL certificate configuration
1. Before continuing your SSL Cert setup, please ensure your DNS is pointing to your IP for CertBot verification.<br>
2. Enter y to install a SSL cert.
3. After the installation of SSL cert is complete, run the command below and change **[DOMAIN_NAME]** to your domain name.
```
sudo crontab -e
```


## Expected error/s

**Ruby version 2.3.3 while Gemfile indicates 2.x.x**<br>
Change ruby '2.3.3' at :
```
sudo nano /srv/www/Gemfile
```

**PG cannot be installed**<br>
Run :
```
sudo gem install pg -v '1.1.4' --source 'https://rubygems.org/'
```


