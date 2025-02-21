#!/bin/bash
sudo amazon-linux-extras install mariadb10.5
sudo amazon-linux-extras install php8.2

sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
wget https://wordpress.org/latest.tar.gz
tar zxf latest.tar.gz

sudo mv wordpress/* /var/www/html
sudo systemctl restart httpd
sudo rm -rf /var/www/html/index.html

sudo systemctl start mariadb
sudo systemctl enable mariadb