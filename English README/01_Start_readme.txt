Welcome to the Ansible Playbook for Installing Borg

Preparation:
!!!IMPORTANT!!!

Before we start, ensure that all files are located in the same place.
Required files in one storage location:

Playbook.yaml
inventory.ini
autoconfig.sh
ansible.cfg
config_vars.cfg
first_step.sh
password.yml

 
------------------------------------------------------------------------------------------------------

Installation:
Open the directory where you have stored the above-mentioned files.
Then execute the following command:

bash first_step.sh

-After starting, an editor will open after a short time where you must replace the example data with your own.
-Next, another editor will open for the Vault, where passwords are stored. After completion, assign a Vault password.
-Finally, the last editor will open for entering the IP address of the target device where Borg_Backup will be installed later.
-----------------------------------------------------------------------------------------------------------------------------------------------

Once the installation is complete, continue with 02_Config_Autobackup_readme.txt.