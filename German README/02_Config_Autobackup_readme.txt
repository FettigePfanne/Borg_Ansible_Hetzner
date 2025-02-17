Konfiguration für die Autobackups in Borg

Nach der Installation von Borg wurden zwei Autobackup Scripte erstell.
Dateipfad der Scripte:
/usr/local/bin

In der Datei autobackup.sh ist bis jetzt noch kein verzeichnis eingegeben welche Ordner gesichert werden.
dort einfach wie in dem beispiel code die pfade eingeben:
borg create -v --stats --compression lzma ssh://u123456@u123456.your-storagebox.de:23/home/backups/test::'{now:%Y-%m-%d_%H:%M}' /usr/local/bin /home/userXY 

Damit der Speicher nicht überläuft werden Backus automatisch gelöscht.
borg prune -v --list --keep-hourly=3 --keep-daily=7 --keep-weekly=4 --keep-monthly=12 ssh://u123456@u123456.your-storagebox.de:23/home/backups/test


Zur Erklärung:
--keep-hourly=3 jede Stunde wird ein backup erstellt und nur die 3 Neusten bleiben erhalten alle älteren werden gelöscht.
Das selbe für die Tägliche Backups davon bleiben die letzen 7 erhalten. Und so kann man sich den Rest vorstellen

Um jetzt einzustellen wie oft Backups gemacht werden muss man den crontab öffnen:
crontab -e 
Bei erstmaliger nutzung wird gefragt im welchem Editor man den Crontab öffnen möchte. Einfach den ersten Wählen den "nano" Editor.
Danach wird folgendes auftauchen



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

Dort werden Stündlich, Täglich und Wöchentlich normale Backups erstellt. Monatlich und Jährlich werden Full-Backups erstellt. 
Dies kann bei belieben geändert werden. Zur Hilfe der Zeit fesstellung wann und wie spät ein Backup ausgeführt wird ist ist ein link dabei wo man sowas nachschlagen kann.
https://crontab.cronhub.io

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Konfiguration Abgeschlossen.
Um Backups wiederherzustellen öffnen sie 03_Backup_wiederherstellung_readme.txt