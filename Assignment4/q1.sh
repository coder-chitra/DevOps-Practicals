#installation 
sudo apt update
sudo apt install apache2 wget unzip -y

#check status
sudo systemctl status apache2

# Creating sample project
mkdir -p ~/sample-project
cd ~/sample-project

cat > index.html <<'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Sample DevOps Project</title>
</head>
<body>
    <h1>Welcome to My Sample Project</h1>
    <p>Deployed manually on an Ubuntu EC2 instance.</p>
</body>
</html>
EOF

# transferring the file
sudo cp -r ~/sample-project/. /var/www/html/
sudo systemctl enable --now apache2

# Verifying
curl http://localhost...