#!/bin/bash
set -x

{% for folder in backup_cron_folders %}
ln -s "{{ folder }}" .
TO_BACKUP="$TO_BACKUP {{ folder|basename }}" # list of files to backup
{% endfor %}

TIMESTAMP=`date '+%Y%m%d%H%M%S'`

DUMP_PATH={% if not backup_cron_custom_tmp_folder %}"."{% else %}"{{ backup_cron_custom_tmp_folder }}"{% endif %}

# Delete oldest backup
rm "$(ls -t $DUMP_PATH/*.sql.gz | tail -1)"
rm "$(ls -t $DUMP_PATH/*.tar.gz | tail -1)"

{{ backup_cron_dbdump_script }} > $DUMP_PATH/database-backup-$TIMESTAMP.sql
gzip $DUMP_PATH/database-backup-$TIMESTAMP.sql

# Here, we force the owner of every file we add to be our backup_cron_user because for group
# and permissions restoration to work on the other end, we need it to be so. Otherwise, with
# the --same-owner flag, tar begins with the chown, and then oops! it doesn't have permissions
# for chgroup!
tar --owner="{{ backup_cron_user }}" -chzf $DUMP_PATH/files-backup-$TIMESTAMP.tar.gz $TO_BACKUP
