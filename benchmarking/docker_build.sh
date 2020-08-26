#!/bin/bash


# build custom es rally with rally.ini bundled
# https://esrally.readthedocs.io/en/stable/docker.html
docker build --tag my_esrally .

echo "Test run"

docker run --rm my_esrally list tracks
