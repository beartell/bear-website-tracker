#!/bin/bash

if [[ -z "${SERVER_NAME}" || -z "${ELASTIC_URL}" ]]
then
    echo "Variables are not set"
    exit -1
fi

while true
do 
    if [[ -d "/data" ]]
    then
        echo "data klasörü bağlandı"
        break
    fi
    sleep 1
done

if [ -f /home/.CONFIG_OK ]
then
    echo "Already Configured"
else
    sed -i "s#<server_name>#${SERVER_NAME}#g" /usr/share/kibana/config/kibana.yml
    sed -i "s#<elasticsearch_cluster_host>#${ELASTIC_URL}#g" /usr/share/kibana/config/kibana.yml
    
    if [[ -d "/data/plugins" ]]
    then
        echo "Plugins folder already copied."

        rm -rf /usr/share/kibana/plugins
        ln -s /data/plugins /usr/share/kibana/plugins
        echo "Plugins folder linked"
    else
        mkdir /data/plugins
        echo "Plugins folder created"

        mv /usr/share/kibana/plugins /data/
        ln -s /data/plugins /usr/share/kibana/plugins
        echo "Plugins folder linked"

        chown -R kibana:kibana /data/plugins
    fi

    echo "Configuration OK"
    touch /home/.CONFIG_OK
fi

# Files created at run-time should be group-writable, for Openshift's sake.
umask 0002

cd /home && \
nohup /usr/share/kibana/bin/kibana > kibana_nohup_output.log 2>&1 &

# Kibana ya dashboardlar yükleniyor.
if [ -f /data/.RESTORED ]
then
    echo "Data already restored"
    while true
    do
        STATUS_CODE_WITH_1=$(curl -s --write-out " write-out:%{http_code}" -XGET http://localhost:5601/api/status)
        STATUS_CODE_1=$(echo ${STATUS_CODE_WITH_1} | awk -F 'write-out:' '{print $2}')                
        if [[ "${STATUS_CODE_1}" == "200" ]]
        then
            echo "Kibana Started ..."
            break
        fi

        print "Waiting for Kibana"
        sleep 2
    done

else
    while true
    do

        STATUS_CODE_WITH_1=$(curl -s --write-out " write-out:%{http_code}" -XGET http://localhost:5601/api/status)
        STATUS_CODE_1=$(echo ${STATUS_CODE_WITH_1} | awk -F 'write-out:' '{print $2}')                
        if [[ "${STATUS_CODE_1}" == "200" ]]
        then

            echo "Kibana Started ..."
            sleep 2

            # Load Saved Objects
            STATUS_CODE_WITH=$(curl -s --write-out " write-out:%{http_code}" -XPOST -H "Content-Type: application/json" -H "kbn-xsrf: true"  http://localhost:5601/api/saved_objects/_bulk_create -d @/home/saved_objects.json)
            STATUS_CODE=$(echo ${STATUS_CODE_WITH} | awk -F 'write-out:' '{print $2}')            
            if [[ "${STATUS_CODE}" == "200" ]]
            then
                echo "Saved Objects loaded successfully"
            else
                echo "Something gone wrong. Maybe elasticsearch index not loaded. Please Check"
            fi
            break

        fi

        echo "Waiting for Kibana"
        sleep 2

    done

    touch /data/.RESTORED
fi

exec /bin/bash