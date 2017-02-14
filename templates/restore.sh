#!/bin/bash

# WARNING: THIS SCRIPT IS DESTRUCTIVE!!!
# It will **overwrite** persistent data of this project with the ones in the latest backup
# Do not run if the current persistent that is not already backuped up or non-existent!

WORKDIR=`mktemp -d`
cd $WORKDIR

# First of all, let's delete our backed up folders. We do this before extracting in case we're low
# on disk space.
{% for folder in backup_cron_folders %}
rm -rf "{{ folder }}"
{% endfor %}

# Now, lets extract the thing
{{ backup_cron_storage_restore_script_path|mandatory }} | tar -x

# Now, let's move folder back in position
{% for folder in backup_cron_folders %}
mv "{{ folder|basename }}" "{{ folder }}"
{% endfor %}

# And finally, we run restore commands
{% for command in backup_cron_restore_commands %}
{{ command }}
{% endfor %}

cd /tmp
rm -rf "${WORKDIR}"
