ES cluster Benchmarking with esrally using docker
================================================


## Benchmarking against an existing cluster 

1. build custom rally image `my_esrally` with bundled configuration `rally.ini`


		./docker_build.sh
	

1. benchmarking an existing ES Cluster (version 6.8.12) running on the host machine 

	
		# connect from container to MAC host machine 
		export ES_HOST=host.docker.internal:9200
		
		# cluster already provisioned, "benchmark-only" with a track (benchmarking scenario) called "geonames" (POIs from Geonames)
		
		docker run -v $PWD/myrally:/rally/.rally my_esrally --distribution-version=6.8.12 --track=geonames --pipeline=benchmark-only --target-hosts=$ES_HOST


1. Inspect the `race` results:
 
	```
	$ tree myrally/benchmarks/races/
	myrally/benchmarks/races/
	├── 521bebe3-043d-4ebb-ae9a-e4c6d5c67ca0
	│   └── race.json
	└── cb0a37d8-3a8a-402f-9035-38e071be1ed4
	└── race.json
	```

1. Downloaded track data

```
$ tree myrally/benchmarks/data
myrally/benchmarks/data
├── geonames
│   ├── documents-2.json
│   └── documents-2.json.bz2
├── percolator
│   ├── queries-2.json
│   ├── queries-2.json.bz2
│   └── queries-2.json.offset
└── pmc
    └── documents.json.bz2.tmp
```

## Definitions

- **Track** - A track describes one or more benchmarking scenarios, it contains `data` (multiple lines of json documents) and `challenges` (plan of workload)
- **Challenge** - To specify different workloads in the same track you can use so-called challenges



## Useful commands
#### List available tracks

```
$ esrally list tracks


Available tracks:

Name           Description                                                                                                                                                                        Documents    Compressed Size    Uncompressed Size    Default Challenge        All Challenges
-------------  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  -----------  -----------------  -------------------  -----------------------  ------------------------------------------------------------------------------------------------------------------------------------------------------------------
geonames       POIs from Geonames                                                                                                                                                                 11,396,503   252.9 MB           3.3 GB               append-no-conflicts      append-no-conflicts,append-no-conflicts-index-only,append-sorted-no-conflicts,append-fast-with-conflicts
percolator     Percolator benchmark based on AOL queries                                                                                                                                          2,000,000    121.1 kB           104.9 MB             append-no-conflicts      append-no-conflicts
http_logs      HTTP server log data                                                                                                                                                               247,249,096  1.2 GB             31.1 GB              append-no-conflicts      append-no-conflicts,append-no-conflicts-index-only,append-sorted-no-conflicts,append-index-only-with-ingest-pipeline,update,append-no-conflicts-index-reindex-only
geoshape       Shapes from PlanetOSM                                                                                                                                                              60,523,283   13.4 GB            45.4 GB              append-no-conflicts      append-no-conflicts
metricbeat     Metricbeat data                                                                                                                                                                    1,079,600    87.7 MB            1.2 GB               append-no-conflicts      append-no-conflicts
geopoint       Point coordinates from PlanetOSM                                                                                                                                                   60,844,404   482.1 MB           2.3 GB               append-no-conflicts      append-no-conflicts,append-no-conflicts-index-only,append-fast-with-conflicts
nyc_taxis      Taxi rides in New York in 2015                                                                                                                                                     165,346,692  4.5 GB             74.3 GB              append-no-conflicts      append-no-conflicts,append-no-conflicts-index-only,append-sorted-no-conflicts-index-only,update,append-ml,date-histogram
geopointshape  Point coordinates from PlanetOSM indexed as geoshapes                                                                                                                              60,844,404   470.8 MB           2.6 GB               append-no-conflicts      append-no-conflicts,append-no-conflicts-index-only,append-fast-with-conflicts
so             Indexing benchmark using up to questions and answers from StackOverflow                                                                                                            36,062,278   8.9 GB             33.1 GB              append-no-conflicts      append-no-conflicts
eventdata      This benchmark indexes HTTP access logs generated based sample logs from the elastic.co website using the generator available in https://github.com/elastic/rally-eventdata-track  20,000,000   756.0 MB           15.3 GB              append-no-conflicts      append-no-conflicts,transform
nested         StackOverflow Q&A stored as nested docs                                                                                                                                            11,203,029   663.3 MB           3.4 GB               nested-search-challenge  nested-search-challenge,index-only
noaa           Global daily weather measurements from NOAA                                                                                                                                        33,659,481   949.4 MB           9.0 GB               append-no-conflicts      append-no-conflicts,append-no-conflicts-index-only,top_metrics,sub-bucket-aggs
pmc            Full text benchmark with academic papers from PMC                                                                                                                                  574,199      5.5 GB             21.7 GB              append-no-conflicts      append-no-conflicts,append-no-conflicts-index-only,append-sorted-no-conflicts,append-fast-with-conflicts

-------------------------------

```



#### Show track info
```
$ esrally info --track percolator

Showing details for track [percolator]:

* Description: Percolator benchmark based on AOL queries
* Documents: 2,000,000
* Compressed Size: 121.1 kB
* Uncompressed Size: 104.9 MB

================================================
Challenge [append-no-conflicts] (run by default)
================================================

Indexes the whole document corpus using Elasticsearch default settings. We only adjust the number of replicas as we benchmark a single node cluster and Rally will only start the benchmark if the cluster turns green and we want to ensure that we don't use the query cache. Document ids are unique so all index operations are append only. After that a couple of queries are run.

Schedule:
----------
1. delete-index
2. create-index
3. check-cluster-health
4. index (8 clients)
5. refresh-after-index
6. force-merge
7. refresh-after-force-merge
8. wait-until-merges-finish
9. percolator_with_content_president_bush
10. percolator_with_content_saddam_hussein
11. percolator_with_content_hurricane_katrina
12. percolator_with_content_google
13. percolator_no_score_with_content_google
14. percolator_with_highlighting
15. percolator_with_content_ignore_me
16. percolator_no_score_with_content_ignore_me
-------------------------------

```



### Also See:
* https://esrally.readthedocs.io/en/stable/docker.html
* https://github.com/elastic/rally
