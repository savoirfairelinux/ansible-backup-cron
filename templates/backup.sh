#!/bin/bash

rm -rf "{{ backup_client_tmppath|mandatory }}"
mkdir "{{ backup_client_tmppath }}"
cd "{{ backup_client_tmppath }}"

{% for folder in backup_client_folders %}
ln -s "{{ folder }}" .
{% endfor %}

{% if backup_client_dumpscript %}
{{ backup_client_dumpscript }} > dump.sql
{% endif %}

tar -czh * | ssh {{ backup_client_storage_url }} './dump'

