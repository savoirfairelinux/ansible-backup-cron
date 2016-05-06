#!/bin/bash

WORKDIR=`mktemp -d`
cd $WORKDIR

# We want to preserve permissions/ownership as they were when files were backed up
{{ backup_cron_storage_restore_script_path|mandatory }} | tar -x --preserve-permissions --same-owner

{% for folder in backup_cron_folders %}
mkdir -p {{ folder }}
rsync -a {{ folder|basename }}/* {{ folder }}
{% endfor %}

{% if backup_cron_dbrestore_script %}
{{ backup_cron_dbrestore_script }} < dump.sql
{% endif %}

cd /tmp
rm -rf "${WORKDIR}"

