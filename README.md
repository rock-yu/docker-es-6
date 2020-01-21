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
