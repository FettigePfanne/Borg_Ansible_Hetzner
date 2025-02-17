#!/bin/bash
env > /tmp/env_vars.log
# Server-Details
echo "wert von STORAGE_IP: $STORAGE_IP"
echo "Wert von STORAGE_PORT: $STORAGE_PORT"
echo "wert von STORAGE_USERNAME: $STORAGE_USERNAME"
echo "Wert von STORAGE_PASSWORD: $STORAGE_PASSWORD"
echo "Wert von BACKUP_PFAD: $BACKUP_PFAD"
echo "Wert von ORDNER_NAME: $ORDNER_NAME"
echo "Wert von BORG_PASSWORD: $BORG_PASSWORD"


    # 9. Erstellen des neuen Skripts autobackup.sh
    AUTO_BACKUP_PATH="/usr/local/bin/autobackup.sh"

cat <<EOF > "$AUTO_BACKUP_PATH"
#!/usr/bin/env bash

##
echo "###### Backup started: \$(date) ######"


## Bitte am ande des Codes bei /pfad/für/backup die pfade eingeben die gesichert werden sollen
echo "Transfer files ..."
borg create -v --stats --compression lzma ssh://${STORAGE_USERNAME}@${STORAGE_IP}:${STORAGE_PORT}${BACKUP_PFAD}${ORDNER_NAME}::'{now:%Y-%m-%d_%H:%M}' /pfad/für/backup /pfad/für/backup
echo "###### Backup ended: \$(date) ######"

borg prune -v --list --keep-hourly=3 --keep-daily=7 --keep-weekly=4 --keep-monthly=12 ssh://${STORAGE_USERNAME}@${STORAGE_IP}:${STORAGE_PORT}${BACKUP_PFAD}${ORDNER_NAME}
EOF

    # Skript ausführbar machen
    chmod +x "$AUTO_BACKUP_PATH"
    echo "Das Skript wurde unter $AUTO_BACKUP_PATH erstellt und ist jetzt ausführbar."


 #  Erstellen des neuen Skripts autofullbackup.sh
    AUTO_FULL_BACKUP_PATH="/usr/local/bin/autofullbackup.sh"


cat <<EOF > "$AUTO_FULL_BACKUP_PATH"
#!/usr/bin/env bash
echo "###### Full Backup started: \$(date) ######"


## Bitte am ande de Codes bei /pfad/für/backup dei pfade eingeben die gesichert werden sollen
echo "Transfer files ..."
borg create -v --stats --compression lzma ssh://${STORAGE_USERNAME}@${STORAGE_IP}:${STORAGE_PORT}${BACKUP_PFAD}${ORDNER_NAME}::'{now:%Y-%m-%d_%H:%M}'  
/root                                \
    /etc                                 \
    /var/www                             \
    /home                                \
    --exclude /dev                       \
    --exclude /proc                      \
    --exclude /sys                       \
    --exclude /var/run                   \
    --exclude /run                       \
    --exclude /lost+found                \
    --exclude /mnt                       \
    --exclude /var/lib/lxcfs
echo "###### Backup ended: \$(date) ######"

borg prune -v --list --keep-hourly=3 --keep-daily=7 --keep-weekly=4 --keep-monthly=12 ssh://${STORAGE_USERNAME}@${STORAGE_IP}:${STORAGE_PORT}${BACKUP_PFAD}${ORDNER_NAME}
EOF


#!/bin/bash

# Pfad zur Textdatei
CRON_FILE="/usr/local/bin/cronjobs.txt"

# Überprüfen, ob das Verzeichnis existiert
if [ ! -d "/usr/local/bin" ]; then
    echo "Das Verzeichnis /usr/local/bin existiert nicht. Es wird jetzt erstellt."
    sudo mkdir -p /usr/local/bin
fi

# Textdatei mit den Crontab-Einträgen erstellen
echo "Erstelle die Crontab-Datei unter $CRON_FILE"

# Beispielwerte (du kannst hier deine gewünschten Einträge anpassen)
cat <<EOL > $CRON_FILE
#Für die hilfe der Zeiteinstellung können sie hier schauen:https://crontab.cronhub.io

#Stündlich
59 * * * * /usr/local/bin/autobackup.sh > /dev/null 2>&1
#Täglich um 01.00 uhr
0 1 * * * /usr/local/bin/autobackup.sh > /dev/null 2>&1
#Wöchentlich um 01.00 uhr am Samstag
0 1 * * 6 /usr/local/bin/autobackup.sh > /dev/null 2>&1
#Monatlich um 01.00 uhr ma Erten Tag de Monats
0 1 1 * * /usr/local/bin/autofullbackup.sh > /dev/null 2>&1
#Jährlich um 10.00 uhr am 31 Dezember
0 1 31 12 * /usr/local/bin/autofullbackup.sh > /dev/null 2>&1
EOL

echo "Crontab-Datei erstellt."

# Datei-Berechtigungen anpassen
chmod +x $CRON_FILE
echo "Dateiberechtigungen gesetzt."

# Bestehende Crontab sichern
echo "Bestehende Crontab sichern..."
crontab -l > /usr/local/bin/crontab_backup.txt

# Neue Crontab-Einträge hinzufügen
echo "Crontab aktualisieren..."
crontab $CRON_FILE

echo "Fertig! Die Crontab wurde mit den neuen Einträgen aktualisiert."



# Skript ausführbar machen
chmod +x "$EDIT_BACKUP_PATH"
echo "Das Skript wurde unter $EDIT_BACKUP_PATH erstellt und ist jetzt ausführbar."
    echo "-------------------------------------------------"
    echo "-------------------------------------------------"
    echo "-------------------------------------------------"
    echo "Die Haupt-Config wurde erfolgreich abgeschlossen."
    echo "-------------------------------------------------"
    echo "-------------------------------------------------"
    echo "HINWEIS:"
    echo "Bitte schließen sie die Auto Backup einrichtung ab indem sie folgenden command ausführen:"
    echo "nano /usr/local/bin/autobackup.sh"
    echo "Um die Datei bearbeiten zu können wüssen sie die datei mit (sudo) ausführen"
    echo "-----------------------------------------------------------------------------------------"
    echo "-----------------------------------------------------------------------------------------"
