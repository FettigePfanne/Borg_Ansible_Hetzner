How do I restore a backup?

The best approach is to create a folder where the backup will be restored or use an already existing one.
To create a new folder, use:
"sudo mkdir /path/to/folder"
Then navigate to the folder using: "cd /path/to/restore/location"

To list all available backups, use the Borg list command:
"borg list ssh://u445444@u445444.your-storagebox.de:23/home/backups/test"

It is also possible to view the contents of a specific backup:
"borg list ssh://u445444@u445444.your-storagebox.de:23/home/backups/test::backup_name"


Commands to restore backups:
To restore an entire backup, use:
borg extract ssh://u445444@u445444.your-storagebox.de:23/home/backups/test::backup_name

To restore only a specific file, use:
borg extract ssh://u445444@u445444.your-storagebox.de:23/home/backups/test::backup_name /home/dokumente/rolex.txt