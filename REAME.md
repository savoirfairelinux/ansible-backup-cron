# backup-client

Sets up a project for regular database/folder backups to a specified
[backup storage][backup-storage].

## Requirements

* Ansible 2.0+
* Debian Jessie deployment target
* A [backup storage][backup-storage] somewhere.
* A specific user on the system for the project you want to back up.

## Usage

A SSH key is going to be generated for the project user. It's this SSH key that will be used to
push backups on the storage server. To allow for this configuration, the generated public key will
be fetched by the provisioner and then propagated to the storage server.
