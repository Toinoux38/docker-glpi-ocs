#!/bin/bash

display_logo() {
    echo "        _       _                     _           _            _             ";
    echo "       | |     (_)                   | |         | |          | |            ";
    echo "   __ _| |_ __  _  ___   ___ ___     | |       __| | ___   ___| | _____ _ __ ";
    echo "  / _\`| | '_ \| |/ _ \ / __/ __|    | |      / _\`|/ _ \ / __| |/ / _ \ '__|";
    echo " | (_| | | |_) | | (_) | (__\__ \    | |     | (_| | (_) | (__|   <  __/ |   ";
    echo "  \__, |_| .__/|_|\___/ \___|___/    | |      \__,_|\___/ \___|_|\_\___|_|   ";
    echo "   __/ | | |                         | |                                     ";
    echo "  |___/  |_|                         |_|                                     ";
}
display_logo
echo ""
echo "################################################################################"
echo "                     Made with <3 by Macron                        "
echo "################################################################################"
echo ""
sleep 3
source secrets.env

sql_final_file="sql/initdb.sql"

# Lisez le fichier SQL d'origine et remplacez les variables par les valeurs définies
sed -e "s|\${glpi_database_name}|${glpi_database_name}|g" \
    -e "s|\${glpi_database_user}|${glpi_database_user}|g" \
    -e "s|\${glpi_database_password}|${glpi_database_password}|g" \
    -e "s|\${OCS_DB_NAME}|${OCS_DB_NAME}|g" \
    -e "s|\${OCS_DB_USER}|${OCS_DB_USER}|g" \
    -e "s|\${OCS_DB_PASS}|${OCS_DB_PASS}|g" \
    sql/initdb.sql.template > "$sql_final_file"

if [ ! -f ssl/ssl.crt ] || [ ! -f ssl/ssl.key ]; then
    echo "Les fichiers ssl.crt et ssl.key sont manquants dans le dossier ssl/. Génération d'un certificat auto-signé..."
    mkdir -p ssl
    openssl req -x509 -nodes -days 3650 -newkey rsa:4096 -keyout ssl/ssl.key -out ssl/ssl.crt -subj "/C=FR/ST=France/L=Paris/O=entreprise/CN=localhost" 
fi

docker-compose build && docker-compose up -d
