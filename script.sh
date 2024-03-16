#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo "Hello Vijay Giduthuri" | sudo tee /var/www/html/index.html 
