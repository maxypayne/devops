#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Update system packages
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install prerequisites
echo "Installing prerequisites..."
sudo apt install -y curl ca-certificates tzdata openssh-server

## Install Postfix for email notifications (optional)
#echo "Installing Postfix..."
#sudo apt install -y postfix
#
## Prompt for Postfix configuration (Internet Site)
#if [ -x "$(command -v debconf-set-selections)" ]; then
#    echo "postfix postfix/mailname string your_domain_or_ip" | sudo debconf-set-selections
#    echo "postfix postfix/main_mailer_type string 'Internet Site'" | sudo debconf-set-selections
#fi

# Add GitLab CE repository
echo "Adding GitLab CE repository..."
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash

## Prompt for external URL
#read -p "Enter the external URL for GitLab (e.g., http://your_domain_or_ip): " EXTERNAL_URL
#if [[ -z "$EXTERNAL_URL" ]]; then
#    echo "External URL is required. Exiting."
#    exit 1
#fi

# Install GitLab CE
echo "Installing GitLab CE..."
sudo EXTERNAL_URL="mlucov.gitlab.com" apt install -y gitlab-ce

# Configure GitLab
echo "Configuring GitLab..."
sudo gitlab-ctl reconfigure

sudo cat /etc/gitlab/initial_root_password

echo "GitLab CE installation complete. Access it at: $EXTERNAL_URL"

echo "Installing GitLab runner"
curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash


sudo gitlab-runner register \
  --non-interactive \
  --url "http://192.168.56.11" \
  --registration-token "GR1348941e8zzsuys1kX5XaDdB9cN" \
  --description "This is my awesome project" \
  --tag-list "awesome" \
  --maintenance-note "just do it" \
  --executor "shell"

sudo systemctl restart gitlab-runner


#before_script:
 #  - apt-get update && apt-get install -y openjdk-17-jdk
 #  - export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
 #  - export PATH=$JAVA_HOME/bin:$PATH
 #  - echo "JAVA_HOME=$JAVA_HOME"
