#!/bin/bash -ex

# Each instance needs to present the same host key when accessed
# through the load balancer. For demo purposes we are going to
# use a hardcoded key, in a production environment you should
# generate a unique key.
cp ./ssh_host_rsa_key /etc/filemage/ssh_host_rsa_key
chmod 600 /etc/filemage/ssh_host_rsa_key

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

# Write the database connection info to the application config.
cat > /etc/filemage/config.yml << EOF
tls_certificate: /opt/filemage/default.cert
tls_certificate_key: /opt/filemage/default.key
pg_host: $1
pg_user: $2@$3
pg_password: $4
pg_database: filemage
pg_ssl_mode: require
sftp_host_keys:
  - /etc/filemage/ssh_host_rsa_key
EOF

# Write the session secret defined in the template to each
# instance so cookies can be shared across instances.
echo $5 > /opt/filemage/.secret

systemctl restart filemage

# Disable the database that comes pre-installed on the image.
systemctl stop postgresql
systemctl disable postgresql
