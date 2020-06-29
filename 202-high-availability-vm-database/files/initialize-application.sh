#!/bin/bash -ex

# Each instance needs to present the same host key when accessed
# through the load balancer. For demo purposes we are going to
# use a hardcoded key, in a production environment you should
# generate a unique key.
cp ./ssh_host_rsa_key /etc/filemage/ssh_host_rsa_key
chmod 600 /etc/filemage/ssh_host_rsa_key

# Write the database connection info to the application config.
cat > /etc/filemage/config.yml << EOF
tls_certificate: /opt/filemage/default.cert
tls_certificate_key: /opt/filemage/default.key
pg_host: $1
pg_user: $2
pg_password: $3
pg_database: filemage
pg_ssl_mode: require
sftp_host_keys:
  - /etc/filemage/ssh_host_rsa_key
EOF

# Write the session secret defined in the template to each
# instance so cookies can be shared across instances.
echo $4 > /opt/filemage/.secret

systemctl restart filemage

# Disable the database that comes pre-installed on the image.
systemctl stop postgresql
systemctl disable postgresql
