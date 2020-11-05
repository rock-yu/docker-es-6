FROM docker.elastic.co/elasticsearch/elasticsearch:6.8.12

COPY --chown=elasticsearch:elasticsearch new-entry.sh /usr/local/bin/new-entry.sh
COPY elasticsearch.yml /usr/share/elasticsearch/config/
COPY elastic-stack-ca.p12 /usr/share/elasticsearch/config/certs/
COPY elastic-certificates.p12 /usr/share/elasticsearch/config/certs/

ENTRYPOINT ["/usr/local/bin/new-entry.sh"]
