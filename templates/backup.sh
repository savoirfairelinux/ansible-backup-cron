#!/bin/bash

WORKDIR=`mktemp -d`
cd $WORKDIR

{% for folder in backup_client_folders %}
ln -s "{{ folder }}" .
{% endfor %}

{% if backup_client_dumpscript %}
{{ backup_client_dumpscript }} > dump.sql
{% endif %}

tar -czh * | {{ backup_client_storage_script_path }}

cd /tmp
rm -rf "${WORKDIR}"

