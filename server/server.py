from flask import Flask, request
from SearchEngine import SearchEngine
from QueryResponse import QueryResponse, from_query_result

# --------------------------------|
# In order to execute run:        |
#     `python server.py`          |
# --------------------------------|

app = Flask(__name__, static_url_path="", static_folder="web/static")
engine = SearchEngine()


@app.route("/")
def root():
    return app.send_static_file("index.html")


@app.route("/query", methods=["GET"])
def query():
    query_text = request.args["query"]
    svd_param = request.args.get("svd")
    k_largest = request.args.get("k")

    k = 20
    if k_largest:
        k = int(k_largest)

    use_svd = True
    if svd_param == "false":
        use_svd = False

    results = engine.query(query_text, use_svd=use_svd, k_largest=k)
    results = map(from_query_result, results)
    results = filter(lambda res: res.similarity > 0, results)
    results = list(results)

    return repr(results)


@app.route("/svd", methods=["GET"])
def recalculateSVD():
    k = request.args["k"]
    engine.recalcuclateSVD(int(k))

    return "ok"


if __name__ == "__main__":
    app.run(debug=False)
