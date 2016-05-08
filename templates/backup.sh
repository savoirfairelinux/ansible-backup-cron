#!/bin/bash

WORKDIR=`mktemp -d`
cd $WORKDIR

{% for folder in backup_cron_folders %}
ln -s "{{ folder }}" .
{% endfor %}

{% if backup_cron_dbdump_script %}
{{ backup_cron_dbdump_script }} > dump.sql
{% endif %}

# Here, we force the owner of every file we add to be our backup_cron_user because for group
# and permissions restoration to work on the other end, we need it to be so. Otherwise, with
# the --same-owner flag, tar begins with the chown, and then oops! it doesn't have permissions
# for chgroup!
tar -ch --owner="{{ backup_cron_user }}" * | {{ backup_cron_storage_dump_script_path|mandatory }}

cd /tmp
rm -rf "${WORKDIR}"

