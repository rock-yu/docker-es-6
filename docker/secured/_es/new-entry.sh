#!/bin/bash

/usr/local/bin/docker-entrypoint.sh &
PID=$!
while ! nc -z localhost 9200; do 
    echo "Waiting for elasticsearch to be ready ..."
    sleep 5
done

#echo -e "\nActiviating Trial license ..."
#while ! $(curl -s -X POST "http://localhost:9200/_xpack/license/start_trial?acknowledge=true" | grep '"acknowledged":true' 2>&1 > /dev/null); do
#    sleep 2
#    echo -e "\nRetry activating Trial license"
#done

echo -e "\nSetup built-in users ..."
ESPASS=$(echo y | /usr/share/elasticsearch/bin/elasticsearch-setup-passwords auto -Expack.security.http.ssl.truststore.path=certs/elastic-certificates.p12 -Expack.security.http.ssl.verification_mode=certificate | grep 'elastic = ' | cut -d' ' -f4)

echo -e "\nConfigure well-known superuser password ..."
curl -k -s -u elastic:${ESPASS} -X POST "https://localhost:9200/_xpack/security/user/elastic/_password" -H 'Content-Type: application/json' -d '{"password":"elastic"}'

wait $PID
