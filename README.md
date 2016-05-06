# backup-cron

Sets up a project for regular database/folder backups to a specified backup storage script (
probably [zbackup][ansible-zbackup]).

This role also sets up a restore script.

It also sets up a cron job to do call our backup script regularly. Of course, restoration is
expected to be triggered manually, so we don't set up any cron for it.

## Requirements

* Ansible 2.0+
* Debian Jessie deployment target
* A backup storage script that takes a tar file as stdin and properly backs it up
* A backup storage script spits its latest tar file to stdout
* Optionally, a script that dumps/restore a DB SQL file

## Usage

```
role: backup_cron
backup_cron_user: project_user
backup_cron_backup_script_path: /path/to/script_that_launches_the_backup
backup_cron_restore_script_path: /path/to/script_that_restores_backup_contents
backup_cron_storage_dump_script_path: /path/to/zbackup_dump_script
backup_cron_storage_restore_script_path: /path/to/zbackup_getlatest_script
backup_cron_dbdump_script: /path/to/script_that_dumps_sql
backup_cron_dbrestore_script: /path/to/script_that_restores_sql
backup_cron_folders:
  - /path/to/foder_to_backup
  - /and/another
backup_cron_enable_cron: yes
backup_cron_cron_args:
  hour: 1
```

[ansible-zbackup]: https://github.com/savoirfairelinux/ansible-zbackup
