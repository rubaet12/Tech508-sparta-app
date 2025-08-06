#!/bin/bash

# Provisioning Script

echo "update..."
sudo DEBIAN_FRONTEND=noninteractive apt-get update
echo "update done"
echo

echo "upgrade..."
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
echo "upgrade done"
echo

echo "install nginx..."
sudo DEBIAN_FRONTEND=noninteractive apt install nginx -y
echo "nginx install complete"
echo

# Configure Nginx as reverse proxy
echo "Configuring Nginx reverse proxy..."

# Backup default config
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak

# Replace try_files line with proxy_pass
sudo sed -i 's|try_files.*|proxy_pass http://localhost:3000;|' /etc/nginx/sites-available/default

# Restart nginx to apply changes
sudo systemctl restart nginx
echo "Nginx reverse proxy configured and restarted"
echo

echo "install node.js..."
sudo DEBIAN_FRONTEND=noninteractive bash -c "curl -fsSL https://deb.nodesource.com/setup_20.x | bash -" && \
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs
echo "node.js install complete"
echo

echo "cloning git repo..."
git clone https://github.com/rubaet12/Tech508-sparta-app.git repo
cd repo
echo "git cloning complete"
echo

echo "installing npm dependencies..."
npm install
echo "npm install complete"
echo

# Set MongoDB environment variable
export DB_HOST=mongodb://172.31.31.106:27017/posts
echo "db_host is set"
echo

# Kill any process using port 3000
echo "Checking if anything is already using port 3000..."
PID=$(sudo lsof -t -i:3000 || true)
if [ -n "$PID" ]; then
  echo "Port 3000 is in use by PID $PID. Killing..."
  sudo kill $PID
  echo "Port 3000 cleared."
else
  echo "Port 3000 is free."
fi
echo

# Start app in background
npm start &


