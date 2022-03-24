import flask
from flask import request, jsonify

app = flask.Flask(__name__)
app.config["DEBUG"] = True


@app.route('/', methods=['GET'])
def home():
    return "<h1>Welcome to code challenge</h1><p>To get the version of application please use <a href=\"http://localhost:5000/version\">http://localhost:5000/version</a> URL in browser.</p>"


@app.route('/version', methods=['GET'])
def api_all():
    with open('version.txt') as f:
        lines = f.readlines()
    return jsonify(lines)


@app.errorhandler(404)
def page_not_found(e):
    return "<h1>404</h1><p>The resource could not be found.</p>", 40

if __name__ == '__main__':
    app.run(host='0.0.0.0')