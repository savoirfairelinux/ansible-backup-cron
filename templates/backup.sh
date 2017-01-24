#!/bin/bash

WORKDIR=`mktemp -d`
cd $WORKDIR

# In the tar command below, we can't use "*" to tell it to tar everything because it's going to
# ignore hidden folders. Explicitly listing our subitems is the simplest idea we could come up
# with.
TO_BACKUP=""

{% for folder in backup_cron_folders %}
ln -s "{{ folder }}" .
TO_BACKUP="${TO_BACKUP} {{ folder|basename }}"
{% endfor %}

{% for folder in backup_cron_backup_script %}
{{ folder.dump_command }}
TO_BACKUP=" {{ folder.folder_to_backup }}  ${TO_BACKUP}"
{% endfor %}

# Here, we force the owner of every file we add to be our backup_cron_user because for group
# and permissions restoration to work on the other end, we need it to be so. Otherwise, with
# the --same-owner flag, tar begins with the chown, and then oops! it doesn't have permissions
# for chgroup!
tar -ch --owner="{{ backup_cron_user }}" ${TO_BACKUP} | {{ backup_cron_storage_dump_script_path|mandatory }}

cd /tmp
rm -rf "${WORKDIR}"
