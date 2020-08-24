## Search Engine

This repository contains modest implementation of web search engine.

In a nutshell I have indexed over 10k wikipedia articles, serialized them to sparse matrix, calculated Singular Value Decomposition out of it and performed low-rank approximation to get better results by taking into account words which are close semantically (synonyms).

## Here's link to deployed application

[link](https://wikipedia-search-engine.herokuapp.com/)

You may recalculate low-rank approximation using different rank (k parmeter) and use entire matrix without applying svd at all! Have fun :)

## Running the code locally

To make running the code a breeze I have created a dockerfile together with script which builds an image and runs the container:
`./run-locally.sh`

Please note that this repository weights around 70 Mb thanks to serialized matrices.
