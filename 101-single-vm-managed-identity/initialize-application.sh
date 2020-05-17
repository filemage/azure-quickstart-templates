#!/bin/bash -ex

cat > /etc/filemage/config.yml << EOF
tls_certificate: /opt/filemage/default.cert
tls_certificate_key: /opt/filemage/default.key
pg_user: filemage
pg_host: /var/run/postgresql/
pg_database: filemage
ftp_data_port_start: 32768
ftp_data_port_end: 60999
EOF

systemctl restart filemage
