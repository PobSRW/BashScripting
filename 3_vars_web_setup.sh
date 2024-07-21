#!/bin/bash

# Variable Declaration
PACKAGE="httpd wget unzip"
SERVICE="httpd"
URL='https://www.tooplate.com/zip-templates/2098_health.zip'
FILE_NAME='2098_health'
TEMPDIR="/tmp/webfiles"

# Installing Dependencies
echo "########################################"
echo "Installing packages."
echo "########################################"
sudo yum install $PACKAGE -y > /dev/null
echo

# Start & Enable Service
echo "########################################"
echo "Start & Enable HTTPD Service"
echo "########################################"
sudo systemctl start $SERVICE
sudo systemctl enable $SERVICE
echo

# Creating Temp Directory
echo "########################################"
echo "Starting Artifact Deployment"
echo "########################################"
mkdir -p $TEMPDIR
cd $TEMPDIR
echo

wget $URL > /dev/null
unzip $FILE_NAME.zip > /dev/null
sudo cp -r $FILE_NAME/* /var/www/html/
echo

# Bounce Service
echo "########################################"
echo "Restarting HTTPD service"
echo "########################################"
systemctl restart $SERVICE
echo

# Clean Up
echo "########################################"
echo "Removing Temporary Files"
echo "########################################"
rm -rf $TEMPDIR
echo

sudo systemctl status $SERVICE
ls /var/www/html/
