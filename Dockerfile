FROM python:3

WORKDIR /usr/src/search-engine

COPY . .

RUN pip install --no-cache-dir -r requirements.txt
RUN python ./setup/download-nltk.py

EXPOSE 5000

CMD ["python", "./server.py"]
