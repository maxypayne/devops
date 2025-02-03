sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm
#Désactivez le module PostgreSQL intégré à votre système pour éviter d’installer la mauvaise version :
sudo dnf -qy module disable postgresql
#Installez le serveur PostgreSQL en exécutant cette commande. Si vous souhaitez installer une autre version, remplacez 17 par le numéro correspondant
sudo dnf install -y postgresql17-server

#Initialiser la base de données pour mettre en place les fichiers et la configuration nécessaires à PostgreSQL :
sudo /usr/pgsql-17/bin/postgresql-17-setup initdb

#Lancez et activez PostgreSQL au démarrage en exécutant les commandes suivantes :
sudo systemctl enable postgresql-17

sudo systemctl start postgresql-17

#Se connecter au shell PostgreSQL
#Pour gérer votre base de données, vous devez vous connecter à l’interpréteur de commandes PostgreSQL ou psql.
# Vous pouvez le faire en passant à l’utilisateur root postgres, qui est préconfiguré lors de l’installation
sudo su postgres
psql

CREATE ROLE maximka WITH LOGIN PASSWORD 'Zip906kool9';

CREATE DATABASE books;
\c books
CREATE SCHEMA booksSchema;
CREATE TABLE booksSchema.book (
    id int primary key,
    name varchar
);


vim /var/lib/pgsql/17/data/postgresql.conf
vim /var/lib/pgsql/17/data/pg_hba.conf
sudo systemctl restart postgresql-17


