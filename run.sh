#!/bin/bash

app="search-engine"
sudo docker build -t ${app} .
sudo docker run --rm -p 8080:5000 --name ${app} ${app}
