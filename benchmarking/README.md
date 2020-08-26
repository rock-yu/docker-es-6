Benchmarking ES cluster with esrally in docker
================================================

1. build custom rally image with bundled `rally.ini`

```
./docker_build.sh
```

2. run benchmarking with docker against ES 6.8.1 on host machine

```
export ES_HOST=host.docker.internal:9200

docker run -v $PWD/myrally:/rally/.rally my_esrally --distribution-version=6.8.12 --track=percolator --pipeline=benchmark-only --target-hosts=$ES_HOST
```


### Also See:
* https://esrally.readthedocs.io/en/stable/docker.html
* https://github.com/elastic/rally