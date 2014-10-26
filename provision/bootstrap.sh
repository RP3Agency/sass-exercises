#!/usr/bin/env bash

# Now go forth and provision...

echo "Installing Node and npm"
apt-get update >/dev/null 2>&1
apt-get install -y software-properties-common python-software-properties >/dev/null 2>&1
apt-get install -y python g++ make >/dev/null 2>&1
add-apt-repository -y ppa:chris-lea/node.js >/dev/null 2>&1
apt-get update >/dev/null 2>&1
apt-get install -y nodejs >/dev/null 2>&1

echo "Installing Ruby"
apt-get install -y ruby-full build-essential >/dev/null 2>&1
apt-get install -y rubygems >/dev/null 2>&1

echo "Installing Bundler"
gem install bundler >/dev/null 2>&1

echo "Installing Sass and other Sass-related things via Bundler"
cd /vagrant # Let's just make doubly sure we're in the correct directory
sudo -u vagrant bundle install >/dev/null 2>&1

echo "Installing gulp globally"
npm install gulp -g >/dev/null 2>&1

echo "Installing Local Packages"
cd /vagrant
npm install >/dev/null 2>&1

echo "Installing apache2..."
apt-get update >/dev/null 2>&1
apt-get install -y apache2 >/dev/null 2>&1
service apache2 stop
chown vagrant:vagrant /var/lock/apache2
rm -rf /var/www
ln -fs /vagrant /var/www
a2enmod rewrite
sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/sites-enabled/000-default
sed -i 's/www-data/vagrant/' /etc/apache2/envvars
service apache2 start
