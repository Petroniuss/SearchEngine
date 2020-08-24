# First Stage - Building Angular application to /web/static
FROM node:10-alpine AS build-client-stage

RUN mkdir -p /app/front

WORKDIR /app/front

COPY ./front .

RUN npm install && ng build --prod

# Second Stage - Getting all neccessary dependencies to run flask app
FROM python:3

WORKDIR /app

COPY ./server .
COPY --from=build-client-stage /app/server/resources/web/static /app/server/resources/web/static

RUN pip install --no-cache-dir -r requirements.txt
RUN python ./setup/download-nltk.py

EXPOSE 8080

CMD ["python", "./server.py"]
