#!/bin/bash

set -e  # Stop script on error

# Variables
NEXUS_URL="http://192.168.56.14:8081/repository/angular-app/app.zip"
APP_DIR="/var/www/html/app"
ZIP_FILE="/tmp/app.zip"

echo "Updating system packages..."
sudo apt-get update -y

echo "Installing required packages..."
sudo apt-get install -y unzip apache2

echo "Downloading application ZIP from Nexus..."
curl -o $ZIP_FILE $NEXUS_URL

echo "Extracting application..."
sudo mkdir -p $APP_DIR
sudo unzip -o $ZIP_FILE -d $APP_DIR
sudo rm -f $ZIP_FILE

echo "Setting permissions..."
sudo chown -R www-data:www-data $APP_DIR
sudo chmod -R 755 $APP_DIR

echo "Configuring Apache..."
sudo tee /etc/apache2/sites-available/000-default.conf > /dev/null <<EOF
<VirtualHost *:80>
    DocumentRoot $APP_DIR
    <Directory $APP_DIR>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF

echo "Restarting Apache..."
sudo systemctl restart apache2

echo "Application deployment completed!"

#curl -o /tmp/app.zip -u admin:maxypayne "http://192.168.56.14:8081/repository/angular-app/app.zip"
#unzip -o /tmp/app.zip -d /var/www/html/app
