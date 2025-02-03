#!/bin/bash

# Étape 1 : Préparer l’environnement
echo "[1/6] Mise à jour du système et installation de Java..."
sudo apt update && sudo apt upgrade -y
sudo apt install openjdk-17-jdk -y

wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz -P /tmp
sudo tar -xvf /tmp/latest-unix.tar.gz -C /opt


sudo mv /opt/nexus-3.* /opt/nexus

sudo useradd -M -d /opt/nexus -s /bin/bash nexus
sudo chown -R nexus:nexus /opt/nexus /opt/sonatype-work

sudo echo  run_as_user="nexus" > /opt/nexus/bin/nexus.rc

sudo chmod +x /opt/nexus/bin/nexus

sudo nano /etc/systemd/system/nexus.service

[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target


sudo systemctl daemon-reload

sudo systemctl enable nexus
sudo systemctl start nexus
