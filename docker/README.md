## start 2 nodes cluster

    docker-compose -f docker-compose-es-cluster.yml up -d

## shutdown cluster

    docker-compose -f docker-compose-es-cluster.yml down

## handy shortcuts

    # remove elastic containers
    docker ps -a  | grep elastic | cut -d' ' -f1 | xargs docker rm
   
    #show indices excluding internal monitoring/kibana indexes
    es -v indices | grep -E -v ".monitoring|.kibana"

## index sample document
    
    curl -XPOST "localhost:9200/twitter/_doc" -H "Content-Type: application/json" -d'{
        "user": "kimchy",
        "postDate": "2009-11-15T13:12:00",
        "message": "Trying out Elastic Search, so far so good"
        }'
