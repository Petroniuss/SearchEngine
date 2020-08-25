## Search Engine

This repository contains modest implementation of web search engine.

In a nutshell I have indexed over 10k wikipedia articles, serialized them to sparse matrix, calculated Singular Value Decomposition out of it and performed low-rank approximation which yields better resuts as now we also find documents which contain words which are semantically close (synonyms) to our query.

Making request means vectorizing the query (q) using previously construced bag of words (which contains around 44k words) and calculating cosine of an angle between q and each document d_j (each row in sparse matrix). This can be optimized using matrix multiplication and in the end I return k documents having smallest angle between q (or equivalently highest cosine value).

## Deployed application

[Here is a link to deployed application on Heroku built with Docker](https://wikipedia-search-engine.herokuapp.com/)

You may recalculate low-rank approximation using different rank (k parmeter) and use entire matrix without applying svd at all! Have fun :)

## Running the code locally

To make running the code a breeze I have created a dockerfile together with script which builds an image and runs the container:
`./run-locally.sh`

After that you may open your preferred browser at `localhost:5000`.

Please note that this repository weighs a lot (around 70 Mb) due to serialized matrices.

## Project structure

Front is an angular client while backend is small flask app.

You may also notice that there are scripts for scraping the wikipedia and preprocessing these documents:

- parsing html documents
- stemming (using Porter Stemming Algorithm)
- creating bag of words etc..
