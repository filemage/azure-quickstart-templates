#!/bin/bash -ex

# Mount data disk.
sudo mkfs -t xfs /dev/disk/azure/scsi1/lun0
sudo mkdir -p /var/lib/postgresql/12/main
sudo mount /dev/disk/azure/scsi1/lun0 /var/lib/postgresql/12/main
echo "/dev/disk/azure/scsi1/lun0 /var/lib/postgresql/12/main xfs defaults,nofail 0 2" >> /etc/fstab

# Add PostgreSQL 12 apt repository and install.
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)"-pgdg main > /etc/apt/sources.list.d/apt_postgresql_org_pub_repos_apt.list
apt-get update -y
apt-get install -y postgresql-12

# Download pg_partman extension and install.
curl -o /tmp/postgresql-12-partman_4.2.2_amd64.deb "https://filemagepublic.blob.core.windows.net/deb/postgresql-12-partman_4.2.2_amd64.deb"
dpkg -i /tmp/postgresql-12-partman_4.2.2_amd64.deb

echo "listen_addresses = '0.0.0.0'" >> /etc/postgresql/12/main/postgresql.conf
echo "shared_preload_libraries = 'pg_partman_bgw'" >> /etc/postgresql/12/main/postgresql.conf

# Allow all, access is further restricted in network security group.
echo "host    all             all             0.0.0.0/0               md5" >> /etc/postgresql/12/main/pg_hba.conf

# Restart so pg_partman extension is available when we initialize the application database and partman schema.
systemctl restart postgresql

su postgres -c 'psql' << EOL
CREATE USER $1 WITH PASSWORD '$2';
CREATE DATABASE filemage OWNER $1;
EOL

su postgres -c 'psql -d filemage' << EOL
CREATE SCHEMA IF NOT EXISTS partman;
CREATE EXTENSION IF NOT EXISTS pg_partman SCHEMA partman;
GRANT ALL ON SCHEMA partman TO filemage;
GRANT ALL ON ALL TABLES IN SCHEMA partman TO filemage;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA partman TO filemage;
GRANT EXECUTE ON ALL PROCEDURES IN SCHEMA partman TO filemage;
EOL

# Configure pg_partman background worker to use the filemage database.
echo "pg_partman_bgw.interval = 1800" >> /etc/postgresql/12/main/postgresql.conf
echo "pg_partman_bgw.role = '$1'" >> /etc/postgresql/12/main/postgresql.conf
echo "pg_partman_bgw.dbname = 'filemage'" >> /etc/postgresql/12/main/postgresql.conf

# Restart again to apply new pg_partman settings.
systemctl restart postgresql
