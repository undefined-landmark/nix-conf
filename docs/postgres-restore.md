# Restoring a Postgres Database

Describing some basic commands to connect to the database and do a restore.


## Connecting

The postgres database are setup by the user `postgres`.
To connect to the databases we will use this user like so: `sudo -u postgres psql`.
This will drop us in de postgres sql terminal.

Some commands that may be useful:

- `\l`: list all databases
- `\q`: exit terminal

On SQL commands remember to type the `;`!


## Restoring

To test a restore we will go through the following steps:

- Stop all services using the database
- Optional, for live databases: rename the database
- Restore database

To stop the services we can use `systemctl stop <service-name>`.
To rename the database we first enter the sql terminal and than run `ALTER DATABASE <db-name> RENAME TO <new-db-name>;`.
After that we can restore it with `psql -f /path/to/backup.sql`.

