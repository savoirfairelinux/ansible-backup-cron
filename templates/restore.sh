#!/bin/bash

# WARNING: THIS SCRIPT IS DESTRUCTIVE!!!
# It will **overwrite** persistent data of this project with the ones in the latest backup
# Do not run if the current persistent that is not already backuped up or non-existent!

{% for folder in backup_cron_folders %}
{{ backup_cron_storage_restore_script_path|mandatory }} | tar -x --wildcards --preserve-permissions --same-owner -C "{{ folder|dirname }}" "{{ folder|basename }}/*"
{% endfor %}

{% if backup_cron_dbrestore_script %}
{{ backup_cron_storage_restore_script_path|mandatory }} | tar -x --to-stdout "dump.sql" | {{ backup_cron_dbrestore_script }}
{% endif %}

