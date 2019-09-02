#!/bin/bash

if [[ -z "${ELASTIC_URL}" ]]
then
    echo "Elasticsearch url is not set. Please set ELASTIC_URL when docker run."
    exit -1
fi

if [ -f /home/CONFIG_OK ]
then
    echo "Already Configured"
else
    sed -i "s/127.0.0.1:9200/${ELASTIC_URL}/g" /var/www/html/src/Configuration.php
    echo "Configuration OK"
    touch /home/CONFIG_OK
fi

echo "Apache Starting ..."
service apache2 start

exec /bin/bash