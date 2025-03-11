sudo apt update
sudo apt install -y memcached libmemcached-tools
sudo systemctl enable memcached
sudo systemctl start memcached


sudo nano /etc/memcached.conf

#Trouve la ligne :
#-l 127.0.0.1
#Remplace par :
#-l 0.0.0.0


sudo systemctl restart memcached
