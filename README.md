# `es` command line tool
Elasticsearch `_cat` API command line companions. Work with ES6+ 

* see https://github.com/elastic/es2unix for older versions
* require `curl`

## Installation
    curl -s https://raw.githubusercontent.com/rock-yu/es-util/master/es.sh > /usr/local/bin/es
    
    chmod +x /usr/local/bin/es


## Usage

    es indices
    green open twitter HV2C6JzwS-WSgIj-WxKPAw 5 1 1 0 10.7kb 5.3kb
    
    es shards
    twitter 2 p STARTED 0  230b 172.23.0.3 WJN8ZGg
    twitter 2 r STARTED 0  230b 172.23.0.2 qpTYg9N
    twitter 4 p STARTED 0  230b 172.23.0.3 WJN8ZGg
    twitter 4 r STARTED 0  230b 172.23.0.2 qpTYg9N
    twitter 3 r STARTED 1 4.4kb 172.23.0.3 WJN8ZGg
    twitter 3 p STARTED 1 4.4kb 172.23.0.2 qpTYg9N
    twitter 1 r STARTED 0  230b 172.23.0.3 WJN8ZGg
    twitter 1 p STARTED 0  230b 172.23.0.2 qpTYg9N
    twitter 0 p STARTED 0  230b 172.23.0.3 WJN8ZGg
    twitter 0 r STARTED 0  230b 172.23.0.2 qpTYg9N

    es health
    1598077622 06:27:02 es-docker green 2 2 10 5 0 0 0 0 - 100.0%
    
    es master
    WJN8ZGgwT4aPMGNp12MROQ 172.23.0.3 172.23.0.3 WJN8ZGg
    
    es -v allocation
    shards disk.indices disk.used disk.avail disk.total disk.percent host       ip         node
     5        5.3kb    10.4gb     47.9gb     58.4gb           17 172.23.0.3 172.23.0.3 WJN8ZGg
     5        5.3kb    10.4gb     47.9gb     58.4gb           17 172.23.0.2 172.23.0.2 qpTYg9N

    es -v nodes
    name    ip         master heap.current heap.percent ram.current ram.max ram.percent disk.used disk.total disk.used_percent
    WJN8ZGg 172.23.0.3 *           163.7mb           31       2.4gb   5.8gb          42    10.4gb     58.4gb             17.87
    qpTYg9N 172.23.0.2 -           270.6mb           52       2.4gb   5.8gb          42    10.4gb     58.4gb             17.87

    es version
    cluster_name:es-docker
    version_number:6.8.12