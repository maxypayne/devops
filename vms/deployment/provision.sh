#!/bin/bash

# Variables
NEXUS_URL="http://192.168.56.14:8081/repository/maven-releases/com/mlucov/awesome/1.0.0/awesome-1.0.0-plain.jar"
APP_DIR="/opt/awesome"
JAR_FILE="$APP_DIR/awesome.jar"

# Mise à jour et installation de Java
echo "🔧 Mise à jour du système et installation de Java..."
sudo apt-get update -y
sudo apt-get install -y openjdk-21-jre wget

# Création du dossier de l’application
echo "📁 Création du dossier de l'application..."
sudo mkdir -p $APP_DIR
sudo chown vagrant:vagrant $APP_DIR

# Téléchargement du JAR depuis Nexus
echo "⬇️ Téléchargement de l'application depuis Nexus..."
wget --user=admin --password=Zip906kool9 -O $JAR_FILE $NEXUS_URL

# Vérification du fichier téléchargé
if [ -f "$JAR_FILE" ]; then
    echo "✅ Application téléchargée avec succès."
else
    echo "❌ Échec du téléchargement !" && exit 1
fi

# Lancement de l’application
echo "🚀 Lancement de l'application..."
nohup java -jar $JAR_FILE > $APP_DIR/app.log 2>&1 &
echo "✅ Application démarrée avec succès."
