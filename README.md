# backup-cron

Sets up a project for regular database/folder backups to a specified backup storage script (
probably [zbackup][ansible-zbackup]).

It also sets up a cron job to do this regularly.

## Requirements

* Ansible 2.0+
* Debian Jessie deployment target
* A backup storage script that takes a tar file as stdin and properly backs it up
* A script somewhere that supplies you with a database dump you want to include in your backup

## Usage

```
role: backup_cron
backup_cron_user: project_user
backup_cron_script_path: /path/to/script_that_launches_the_backup
backup_cron_storage_script_path: /path/to/zbackup_dump_script
backup_cron_dumpscript: /path/to/script_that_dumps_sql
backup_cron_folders:
  - /path/to/foder_to_backup
  - /and/another
backup_cron_enable_cron: yes
backup_cron_cron_args:
  hour: 1
```
