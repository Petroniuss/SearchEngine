# First Stage - Building Angular application to /web/static
FROM node:10-alpine AS build-client-stage

RUN mkdir -p /app/front

WORKDIR /app/front

COPY ./front/package.json .
RUN npm install -g @angular/cli && npm install 

COPY ./front .
ARG MODE="production"

RUN echo ${MODE}
RUN ng build `if [ "$MODE" == "production" ]; then echo "--prod"; fi ` 

# Second Stage - Getting all neccessary dependencies to run flask app
FROM python:3

WORKDIR /app/server

COPY ./server/requirements.txt .
RUN pip install -r requirements.txt

RUN python -m nltk.downloader -d /usr/share/nltk_data stopwords words
ENV NLTK_DATA=/usr/share/nltk_data

COPY ./server .
COPY --from=build-client-stage /app/server/resources/web/static ./resources/web/static

EXPOSE ${PORT:-5000}

CMD ["python", "server.py"]
