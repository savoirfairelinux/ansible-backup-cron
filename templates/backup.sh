#!/bin/bash

WORKDIR=`mktemp -d`
cd $WORKDIR

{% for folder in backup_cron_folders %}
ln -s "{{ folder }}" .
{% endfor %}

{% if backup_cron_dbdump_script %}
{{ backup_cron_dbdump_script }} > dump.sql
{% endif %}

tar -ch * | {{ backup_cron_storage_dump_script_path|mandatory }}

cd /tmp
rm -rf "${WORKDIR}"

