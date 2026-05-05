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
METADATA_ENDPOINT="http://169.254.169.254/metadata/instance"
API_VERSION="2021-02-01"

INSTANCE_ID=$(curl -s -H Metadata:true \
  "$METADATA_ENDPOINT/compute/vmId?api-version=$API_VERSION&format=text")

VM_SIZE=$(curl -s -H Metadata:true \
  "$METADATA_ENDPOINT/compute/vmSize?api-version=$API_VERSION&format=text")

AVAIL_ZONE=$(curl -s -H Metadata:true \
  "$METADATA_ENDPOINT/compute/zone?api-version=$API_VERSION&format=text")

PRIVATE_IP=$(curl -s -H Metadata:true \
  "$METADATA_ENDPOINT/network/interface/0/ipv4/ipAddress/0/privateIpAddress?api-version=$API_VERSION&format=text")

PUBLIC_IP=$(curl -s -H Metadata:true \
  "$METADATA_ENDPOINT/network/interface/0/ipv4/ipAddress/0/publicIpAddress?api-version=$API_VERSION&format=text")

# Persist environment variables system-wide
cat >> /etc/environment <<ENVEOF
INSTANCE_ID=$INSTANCE_ID
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
<div class="label">Instance ID</div>
<div class="value">$INSTANCE_ID</div>
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