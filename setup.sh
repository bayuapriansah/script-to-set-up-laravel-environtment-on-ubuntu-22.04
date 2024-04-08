#!/bin/bash

# Update and upgrade
echo "Start Update and Upgrade System"
sudo apt update && sudo apt upgrade -y || { echo "Error: Update and upgrade failed."; exit 1; }
echo "Finish Update and Upgrade System"

# Install base packages
echo "Start install base packages"
sudo apt install -y unzip curl software-properties-common || { echo "Error: Installing base packages failed."; exit 1; }
echo "Finish install base packages"

# Add PHP repository
echo "Start Add PHP repository"
sudo add-apt-repository -y ppa:ondrej/php || { echo "Error: Adding PHP repository failed."; exit 1; }
sudo apt update || { echo "Error: Updating repository failed."; exit 1; }
echo "Finish Add PHP repository"

# Install PHP 8.2
echo "Start install PHP component for Laravel"
sudo apt install -y php8.2 php8.2-cli php8.2-common php8.2-imap php8.2-redis php8.2-snmp php8.2-xml php8.2-zip php8.2-mbstring php8.2-curl php8.2 libapache2-mod-php8.2 php8.2-bcmath php8.2-pdo php8.2-mysql php8.2-tokenizer php8.2-soap php8.2-imagick php8.2-xmlrpc php8.2-gd php8.2-opcache php8.2-intl || { echo "Error: Installing PHP components failed."; exit 1; }
echo "Finish install PHP component for Laravel"

# Check if Nginx is installed
if ! command -v nginx &> /dev/null; then
    echo "Start Install apache2 since no Nginx Installed"
    sudo apt install -y apache2 || { echo "Error: Installing Apache2 failed."; exit 1; }
    sudo systemctl enable apache2 && sudo systemctl start apache2
    echo "Finish Install apache2"
fi

# Check if Composer is installed
if ! command -v composer &> /dev/null; then
    echo "Start Install Composer"
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
    sudo chmod +x /usr/local/bin/composer
    composer || { echo "Error: Installing Composer failed."; exit 1; }
    echo "Finish Install Composer"
fi

# Install Node.js and NPM
echo "Start Install Node.js and NPM"
curl -fsSL https://deb.nodesource.com/setup_21.x | sudo -E bash - || { echo "Error: Adding Node.js repository failed."; exit 1; }
sudo apt-get install -y nodejs || { echo "Error: Installing Node.js and NPM failed."; exit 1; }
echo "Finish Install Node.js and NPM"

# Check if MySQL or MariaDB is installed
if ! command -v mysql &> /dev/null; then
    echo "Start Install MariaDB"
    sudo apt install -y mariadb-server || { echo "Error: Installing MariaDB failed."; exit 1; }
    echo "Finish Install MariaDB"

    # Secure MariaDB installation
    sudo mysql -e "DELETE FROM mysql.user WHERE User='';"
    sudo mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
    sudo mysql -e "DROP DATABASE IF EXISTS test;"
    sudo mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
    sudo mysql -e "FLUSH PRIVILEGES;"
fi

# Prompt user to enter MySQL username and password
read -p "Enter MySQL username: " mysql_user
read -sp "Enter MySQL password: " mysql_password
echo ""

# Create MySQL user and grant privileges
sudo mysql -u root -p <<MYSQL_SCRIPT
CREATE USER '$mysql_user'@'localhost' IDENTIFIED BY '$mysql_password';
GRANT ALL PRIVILEGES ON *.* TO '$mysql_user'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
MYSQL_SCRIPT

echo "MySQL user '$mysql_user' with password $mysql_password created."
echo "Finish created MariaDB/MySQL user and password"
