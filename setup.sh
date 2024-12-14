#!/bin/bash

# Update the system
sudo apt-get update -y

# Install dependencies
sudo apt-get install -y curl unzip mariadb-server nodejs npm composer nginx php php-cli php-mysql git

# Start MySQL service
sudo service mysql start

# Set up the database
mysql -u root -e "CREATE DATABASE pterodactyl; GRANT ALL PRIVILEGES ON pterodactyl.* TO 'ptero'@'localhost' IDENTIFIED BY 'securepassword';"

# Clone the Pterodactyl Panel repository
git clone https://github.com/pterodactyl/panel.git
cd panel

# Install PHP dependencies
cp .env.example .env
composer install --no-dev --optimize-autoloader
php artisan key:generate
php artisan migrate --seed

# Start the Laravel development server
php artisan serve --host=0.0.0.0 --port=8080
