#!/bin/bash

app="search-engine"
sudo docker build -t ${app} .
sudo docker run --rm -p 8080:8080 --name ${app} ${app}
