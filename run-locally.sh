#!/bin/bash

app="search-engine"
sudo docker build --build-arg MODE="local" -t ${app} .
sudo docker run --rm -p 5000:5000 --name ${app} ${app}
