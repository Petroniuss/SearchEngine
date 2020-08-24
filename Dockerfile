# First Stage - Building Angular application to /web/static
FROM node:10-alpine AS build-client-stage

RUN mkdir -p /app/front

WORKDIR /app/front

COPY ./front/package.json .
RUN npm install -g @angular/cli && npm install 

COPY ./front .
RUN ng build --prod

# Second Stage - Getting all neccessary dependencies to run flask app
FROM python:3

WORKDIR /app/server

COPY ./server/requirements.txt .
RUN pip install -r requirements.txt

COPY ./setup .
RUN python download-nltk.py

COPY ./server .
COPY --from=build-client-stage /app/server/resources/web/static .

EXPOSE ${PORT:-5000}

CMD ["python", "server.py"]
