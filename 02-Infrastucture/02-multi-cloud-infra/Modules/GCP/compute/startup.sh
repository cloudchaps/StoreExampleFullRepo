#!/bin/bash
set -e

# Detect package manager and install web server + ec2 metadata utils
if command -v apt &>/dev/null; then
apt update -y
apt install -y apache2 amazon-ec2-utils
systemctl start apache2 && systemctl enable apache2
WEB_ROOT="/var/www/html"
elif command -v dnf &>/dev/null; then
dnf update -y
dnf install -y httpd ec2-metadata
systemctl start httpd && systemctl enable httpd
WEB_ROOT="/var/www/html"
elif command -v yum &>/dev/null; then
yum update -y
yum install -y httpd ec2-metadata
systemctl start httpd && systemctl enable httpd
WEB_ROOT="/var/www/html"
else
echo "Unsupported package manager" && exit 1
fi

# Get VM instance metadata
HOST_NAME=$(hostname)
PRIVATE_IP=$(curl -s -H "Metadata-Flavor: Google" \
  http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/ip)

# Persist environment variables system-wide
cat >> /etc/environment <<ENVEOF
HOST_NAME=$HOST_NAME
INSTANCE_TYPE=$INSTANCE_TYPE
AVAIL_ZONE=$AVAIL_ZONE
PRIVATE_IP=$PRIVATE_IP
PUBLIC_IP=$PUBLIC_IP
ENVEOF

# Create HTML page with EC2 info
cat > $WEB_ROOT/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
<title>EC2 Instance Info</title>
<style>
body { font-family: Arial, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); margin: 0; padding: 20px; }
.container { max-width: 800px; margin: 50px auto; background: white; border-radius: 10px; box-shadow: 0 10px 30px rgba(0,0,0,0.3); padding: 40px; }
h1 { color: #333; text-align: center; margin-bottom: 30px; }
.info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
.info-card { background: #f8f9fa; padding: 20px; border-radius: 8px; border-left: 4px solid #667eea; }
.label { font-weight: bold; color: #667eea; font-size: 14px; text-transform: uppercase; }
.value { font-size: 18px; color: #333; margin-top: 5px; word-break: break-all; }
.footer { text-align: center; margin-top: 30px; color: #666; font-size: 14px; }
</style>
</head>
<body>
<div class="container">
<h1>🚀 EC2 Instance Information</h1>
<div class="info-grid">
<div class="info-card">
<div class="label">Host Name</div>
<div class="value">$HOST_NAME</div>
</div>
<div class="info-card">
<div class="label">Instance Type</div>
<div class="value">$INSTANCE_TYPE</div>
</div>
<div class="info-card">
<div class="label">Availability Zone</div>
<div class="value">$AVAIL_ZONE</div>
</div>
<div class="info-card">
<div class="label">Private IP</div>
<div class="value">$PRIVATE_IP</div>
</div>
<div class="info-card">
<div class="label">Public IP</div>
<div class="value">$PUBLIC_IP</div>
</div>
<div class="info-card">
<div class="label">Hostname</div>
<div class="value">$(hostname -f)</div>
</div>
</div>
<div class="footer">AWS CloudChaps Training Instance</div>
</div>
</body>
</html>