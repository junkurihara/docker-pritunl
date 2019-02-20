#!/bin/sh

LOG_FILE=/var/log/pritunl/pritunl.log

# configure mongodb and log location
echo "Configure MongoDB URI: ${PRITUNL_MONGODB_URI}"
pritunl set-mongodb $PRITUNL_MONGODB_URI

# setup reverse proxy
if [ $PRITUNL_REVERSE_PROXY=true ]; then
    echo "Reverse proxy enabled"
    pritunl set app.reverse_proxy true
    pritunl set app.server_ssl false
    WEBCONSOLE_PORT=9700
else
    echo "Reverse proxy disabled"
    pritunl set app.reverse_proxy false
    pritunl set app.server_ssl true
    WEBCONSOLE_PORT=443
fi


# setup webconsole port
if [ -z "$PRITUNL_WEBCONSOLE_PORT" ]; then
    echo "Set webconsole port: ${CONSOLE_PORT}"
else
    echo "Set custom webconsole port: ${PRITUNL_WEBCONSOLE_PORT}"
    WEBCONSOLE_PORT=$PRITUNL_WEBCONSOLE_PORT
fi


echo "Configure Log location: $LOG_FILE"
cat > /etc/pritunl.conf << EOF
{
    "mongodb_uri": "$PRITUNL_MONGODB_URI", 
    "log_path": "$LOG_FILE", 
    "static_cache": true, 
    "temp_path": "/tmp/pritunl_%r", 
    "bind_addr": "0.0.0.0", 
    "www_path": "/usr/share/pritunl/www", 
    "local_address_interface": "auto", 
    "port": $WEBCONSOLE_PORT
}
EOF

# start pritunl
echo "Start pritunl"
pritunl start
