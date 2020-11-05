## ES with security enabled
 
 
Start a single-node ES cluster secured with native realm and with SSL/TLS enabled

    docker-compose up --build
    
    

Try `curl` the health endpoint with credentials  
    
    curl -k -u elastic:elastic "https://localhost:9200/_cat/health"