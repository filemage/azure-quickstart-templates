#!/bin/bash -ex

# Need .pgpass to avoid password prompt.
echo "$1:5432:filemage:$2@$3:$4" > .pgpass
chmod 600 .pgpass

# Configure the pg_partman extension and associated schema.
# Ideally this would only be done once but since these
# commands are idempotent we can run this on each instance boot
# to keep the automation simple.
PGPASSFILE=.pgpass psql -h $1 -U $2@$3 -d filemage << EOF
CREATE SCHEMA IF NOT EXISTS partman;
CREATE EXTENSION IF NOT EXISTS pg_partman SCHEMA partman;
GRANT ALL ON SCHEMA partman TO filemage;
GRANT ALL ON ALL TABLES IN SCHEMA partman TO filemage;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA partman TO filemage;
GRANT EXECUTE ON ALL PROCEDURES IN SCHEMA partman TO filemage;
EOF

rm .pgpass

# Write the the database connection info to the application config.
cat > /etc/filemage/config.yml << EOF
tls_certificate: /opt/filemage/default.cert
tls_certificate_key: /opt/filemage/default.key
pg_host: $1
pg_user: $2@$3
pg_password: $4
pg_database: filemage
pg_ssl_mode: require
ftp_data_port_start: 32768
ftp_data_port_end: 60999
EOF

systemctl restart filemage

# Disable the database that comes pre-installed on the image.
systemctl stop postgresql
systemctl disable postgresql
