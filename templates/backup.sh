#!/bin/bash

WORKDIR=`mktemp -d`
cd $WORKDIR

{% for folder in backup_cron_folders %}
ln -s "{{ folder }}" .
{% endfor %}

{% if backup_cron_dumpscript %}
{{ backup_cron_dumpscript }} > dump.sql
{% endif %}

tar -ch * | {{ backup_cron_storage_script_path }}

cd /tmp
rm -rf "${WORKDIR}"

