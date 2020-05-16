#!/bin/bash -ex

# Write the the database connection info to the application config.
cat > /etc/filemage/config.yml << EOF
tls_certificate: /opt/filemage/default.cert
tls_certificate_key: /opt/filemage/default.key
pg_host: $1
pg_user: $2
pg_password: $3
pg_database: filemage
pg_ssl_mode: require
ftp_data_port_start: 32768
ftp_data_port_end: 60999
EOF

systemctl restart filemage

# Disable the database that comes pre-installed on the image.
systemctl stop postgresql
systemctl disable postgresql
