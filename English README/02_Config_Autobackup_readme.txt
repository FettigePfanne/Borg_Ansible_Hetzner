Configuration for Automatic Backups in Borg

After installing Borg, two automatic backup scripts have been created.
The file path of the scripts:
/usr/local/bin

In the file autobackup.sh, no directories have been specified yet for which folders should be backed up.
Simply enter the paths as shown in the example code:
borg create -v --stats --compression lzma ssh://u123456@u123456.your-storagebox.de:23/home/backups/test::'{now:%Y-%m-%d_%H:%M}' /usr/local/bin /home/userXY 

To prevent the storage from filling up, backups are automatically deleted:
borg prune -v --list --keep-hourly=3 --keep-daily=7 --keep-weekly=4 --keep-monthly=12 ssh://u123456@u123456.your-storagebox.de:23/home/backups/test


Explanation:
--keep-hourly=3 A backup is created every hour, and only the latest 3 remain; older ones are deleted.
The same applies to daily backups, where the last 7 are retained. The logic follows the same pattern for weekly and monthly backups

To configure how often backups should be made, open the crontab:
crontab -e 
If used for the first time, you will be asked which editor you want to open the crontab with. Simply choose the first option, the "nano" editor.
Then the following will appear:



#For help with time settings, check:https://crontab.cronhub.io



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

Hourly, daily, and weekly backups create standard backups. Monthly and yearly backups create full backups. 
These settings can be adjusted as desired. The provided link helps determine the exact timing of backups.
https://crontab.cronhub.io

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Configuration Completed.
To restore backups, open 03_Backup_restore_readme.txt.