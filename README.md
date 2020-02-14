# docker-es-6
ES 6 Dockerized

# alias to help operations
```
alias es_health="curl -X GET 'localhost:9200/_cat/health?v&pretty'"
alias es_nodes="curl -X GET 'localhost:9200/_cat/nodes?v&h=id,ip,port,v,master&pretty'"
alias es_shards="curl -X GET 'localhost:9200/_cat/shards?v&pretty'"
alias es_indices="curl -X GET 'localhost:9200/_cat/indices?v&pretty'"
alias es_version="curl -X GET 'localhost:9200'"
alias es_cleanup_container="docker ps -a  | grep elastic | cut -d' ' -f1 | xargs docker rm"
```

# es.sh 

Elasticsearch _cat API consumable by the command line. Work with ES6+  (see https://github.com/elastic/es2unix for older versions)

    sudo curl -s https://raw.githubusercontent.com/rock-yu/es-util/master/es.sh > /usr/local/bin/es
    chmod +x /usr/local/bin/es
