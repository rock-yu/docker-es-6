# `es` command line tool
Elasticsearch `_cat` API command line companions. Work with ES6+ 

* see https://github.com/elastic/es2unix for older versions
* require `curl`

## Installation
    curl -s https://raw.githubusercontent.com/rock-yu/es-util/master/es.sh > /usr/local/bin/es
    
    chmod +x /usr/local/bin/es


## Usage

    es version
    cluster_name:es-docker
    version_number:6.8.12

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

    es -v nodes -c id,load_1m,heap.percent,ram.percent
    id   load_1m heap.percent ram.percent
    WJN8    0.03           63          43
    qpTY    0.03           57          43  

    es columns nodes
    id                           | id,nodeId                      | unique node id
    pid                          | p                              | process id
    ip                           | i                              | ip address
    port                         | po                             | bound transport port
    http_address                 | http                           | bound http address
    version                      | v                              | es version
    flavor                       | f                              | es distribution flavor
    type                         | t                              | es distribution type
    build                        | b                              | es build hash
    jdk                          | j                              | jdk version
    disk.total                   | dt,diskTotal                   | total disk space
    disk.used                    | du,diskUsed                    | used disk space
    disk.avail                   | d,da,disk,diskAvail            | available disk space
    disk.used_percent            | dup,diskUsedPercent            | used disk space percentage
    heap.current                 | hc,heapCurrent                 | used heap
    heap.percent                 | hp,heapPercent                 | used heap ratio
    heap.max                     | hm,heapMax                     | max configured heap
    ram.current                  | rc,ramCurrent                  | used machine memory
    ram.percent                  | rp,ramPercent                  | used machine memory ratio
    ram.max                      | rm,ramMax                      | total machine memory
    file_desc.current            | fdc,fileDescriptorCurrent      | used file descriptors
    file_desc.percent            | fdp,fileDescriptorPercent      | used file descriptor ratio
    file_desc.max                | fdm,fileDescriptorMax          | max file descriptors
    cpu                          | cpu                            | recent cpu usage
    load_1m                      | l                              | 1m load avg
    load_5m                      | l                              | 5m load avg
    load_15m                     | l                              | 15m load avg
    uptime                       | u                              | node uptime
    node.role                    | r,role,nodeRole                | m:master eligible node, d:data node, i:ingest node, -:coordinating node only
    master                       | m                              | *:current master
    name                         | n                              | node name
    completion.size              | cs,completionSize              | size of completion
    fielddata.memory_size        | fm,fielddataMemory             | used fielddata cache
    fielddata.evictions          | fe,fielddataEvictions          | fielddata evictions
    query_cache.memory_size      | qcm,queryCacheMemory           | used query cache
    query_cache.evictions        | qce,queryCacheEvictions        | query cache evictions
    request_cache.memory_size    | rcm,requestCacheMemory         | used request cache
    request_cache.evictions      | rce,requestCacheEvictions      | request cache evictions
    request_cache.hit_count      | rchc,requestCacheHitCount      | request cache hit counts
    request_cache.miss_count     | rcmc,requestCacheMissCount     | request cache miss counts
    flush.total                  | ft,flushTotal                  | number of flushes
    flush.total_time             | ftt,flushTotalTime             | time spent in flush
    get.current                  | gc,getCurrent                  | number of current get ops
    get.time                     | gti,getTime                    | time spent in get
    get.total                    | gto,getTotal                   | number of get ops
    get.exists_time              | geti,getExistsTime             | time spent in successful gets
    get.exists_total             | geto,getExistsTotal            | number of successful gets
    get.missing_time             | gmti,getMissingTime            | time spent in failed gets
    get.missing_total            | gmto,getMissingTotal           | number of failed gets
    indexing.delete_current      | idc,indexingDeleteCurrent      | number of current deletions
    indexing.delete_time         | idti,indexingDeleteTime        | time spent in deletions
    indexing.delete_total        | idto,indexingDeleteTotal       | number of delete ops
    indexing.index_current       | iic,indexingIndexCurrent       | number of current indexing ops
    indexing.index_time          | iiti,indexingIndexTime         | time spent in indexing
    indexing.index_total         | iito,indexingIndexTotal        | number of indexing ops
    indexing.index_failed        | iif,indexingIndexFailed        | number of failed indexing ops
    merges.current               | mc,mergesCurrent               | number of current merges
    merges.current_docs          | mcd,mergesCurrentDocs          | number of current merging docs
    merges.current_size          | mcs,mergesCurrentSize          | size of current merges
    merges.total                 | mt,mergesTotal                 | number of completed merge ops
    merges.total_docs            | mtd,mergesTotalDocs            | docs merged
    merges.total_size            | mts,mergesTotalSize            | size merged
    merges.total_time            | mtt,mergesTotalTime            | time spent in merges
    refresh.total                | rto,refreshTotal               | total refreshes
    refresh.time                 | rti,refreshTime                | time spent in refreshes
    refresh.listeners            | rli,refreshListeners           | number of pending refresh listeners
    script.compilations          | scrcc,scriptCompilations       | script compilations
    script.cache_evictions       | scrce,scriptCacheEvictions     | script cache evictions
    search.fetch_current         | sfc,searchFetchCurrent         | current fetch phase ops
    search.fetch_time            | sfti,searchFetchTime           | time spent in fetch phase
    search.fetch_total           | sfto,searchFetchTotal          | total fetch ops
    search.open_contexts         | so,searchOpenContexts          | open search contexts
    search.query_current         | sqc,searchQueryCurrent         | current query phase ops
    search.query_time            | sqti,searchQueryTime           | time spent in query phase
    search.query_total           | sqto,searchQueryTotal          | total query phase ops
    search.scroll_current        | scc,searchScrollCurrent        | open scroll contexts
    search.scroll_time           | scti,searchScrollTime          | time scroll contexts held open
    search.scroll_total          | scto,searchScrollTotal         | completed scroll contexts
    segments.count               | sc,segmentsCount               | number of segments
    segments.memory              | sm,segmentsMemory              | memory used by segments
    segments.index_writer_memory | siwm,segmentsIndexWriterMemory | memory used by index writer
    segments.version_map_memory  | svmm,segmentsVersionMapMemory  | memory used by version map
    segments.fixed_bitset_memory | sfbm,fixedBitsetMemory         | memory used by fixed bit sets for nested object field types and type filters for types referred in _parent fields
    suggest.current              | suc,suggestCurrent             | number of current suggest ops
    suggest.time                 | suti,suggestTime               | time spend in suggest
    suggest.total                | suto,suggestTotal              | number of suggest ops