#!/bin/bash

#Provision 

echo "update..."
sudo apt-get update
echo "update done"
echo

echo "upgrade..."
sudo apt upgrade -y
echo "upgrade done"
echo

echo "install ngnix..."
sudo apt install nginx -y
echo "nginx install complete"
echo

echo "install node.js..."
sudo DEBIAN_FRONTEND=noninteractive bash -c "curl -fsSL https://deb.nodesource.com/setup_20.x | bash -" && \
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs
echo "node.js install complete"
echo

echo "cloning git..."
git clone https://github.com/rubaet12/Tech508-sparta-app.git repo
echo "git cloning complete"
echo

echo "installing npm..."
npm install
echo "npm install complete"
echo

#start npm
npm start

