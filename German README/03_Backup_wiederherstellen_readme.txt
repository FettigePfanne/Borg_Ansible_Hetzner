Wie selle ich ein backup wieder her?

Am besten legt man sich einen ordner an wo das backup wiederhergestellt werden soll oder wählt ein schon bereits vorhandenen
Eien ordner erstellt man mit:
"sudo mkdir /pfad/für/den/ordner"
dann kann man mit "cd /pfad/für/wiederherstellung" in den Ordner

Mit dem Borg list command können sie sich alle verfügbaren backups anzeigen lassen:
"borg list ssh://u445444@u445444.your-storagebox.de:23/home/backups/test"

Es ist auch mäglich sich den ihalt eines Backups anzuzeigen:
"borg list ssh://u445444@u445444.your-storagebox.de:23/home/backups/test::Name_vom_backup"


Mit diesen Befehlen Stellt man die Backups wieder her:
Deiser Befehl stellt das Genze Backu wieder her:
borg extract ssh://u445444@u445444.your-storagebox.de:23/home/backups/test::name_des_backups 

Und mit dem nur eine bestimmte Datei:
borg extract ssh://u445444@u445444.your-storagebox.de:23/home/backups/test::name_des_backups /home/dokumente/rolex.txt