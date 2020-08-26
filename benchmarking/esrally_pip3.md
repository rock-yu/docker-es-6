Benchmarking ES cluster with esrally
===================================

* https://esrally.readthedocs.io/en/stable/quickstart.html
* https://github.com/elastic/rally

**Install rally with pip3**

```
export JAVA_HOME=$(/usr/libexec/java_home)

# update brew and its formulae
brew upgrade
brew install python3

# creating virtual environments

export VIRTUAL_ENV_DIR=~/dev/virtualenv
python3 -m venv $VIRTUAL_ENV_DIR
source $VIRTUAL_ENV_DIR/bin/activate

# install esrally
python3 -m pip install esrally

# test rally and listing available tracks
esrally --version
esrally list tracks

# benchmark existing 6.8.12 cluster running at 9200 locally
esrally --distribution-version=6.8.12 --track=percolator --target-hosts=127.0.0.1:9200 --pipeline=benchmark-only
```

