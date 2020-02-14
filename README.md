# docker-es-6
ES 6 Dockerized

# alias to help operations
```
alias es_cleanup_container="docker ps -a  | grep elastic | cut -d' ' -f1 | xargs docker rm"
```

# es.sh 
Elasticsearch _cat API consumable by the command line. Work with ES6+  (see https://github.com/elastic/es2unix for older versions)

    curl -s https://raw.githubusercontent.com/rock-yu/es-util/master/es.sh > /usr/local/bin/es
    chmod +x /usr/local/bin/es
