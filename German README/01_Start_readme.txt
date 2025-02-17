Wilkommen Zum Ansible Playbook für die Installation für Borg

Vorbereitung:
!!!WICHTIG!!!

Befor wir starten muss sichergestellt werden dass alle Datein sich am selben Ort befinden.
Benötigte datein an einem Speicherort
-Playbook.yaml
-inventory.ini
-autoconfig.sh
-ansible.cfg
-config_vars.cfg
-first_step.sh
-password.yml
 
------------------------------------------------------------------------------------------------------

Installation:
Öffnen sie das verzeichnes wo sie die Oben genannten datein gespeichet haben.
Dann führen sie diesen command aus:

bash first_step.sh

-Nach dem Start öffnen sich nach kurzer Zeit ein editor wo man die Beispieldaten gegen die eigenen ersetzen muss.
-Danach folgt ein weiterer Editor für den Vault wo die Passwörter drin gespeichert werden, nach vollendung vergeben sie ein vault Password.
-Jetzt öffnet sich der Letzte Editor zur eingabe der IP adresse für das Endgerät auf das Später Borg_Backup installiert werden soll

-----------------------------------------------------------------------------------------------------------------------------------------------

Nach vollendung der Installation fahren sie fort mit 02_Config_Autobackup_readme.txt