from flask import Flask
import requests

app = Flask(__name__)

@app.route('/')
def hello():
    return("This URL is not valid!<br>Please try again, For example: <b>'http://[IP]/elastic/elasticsearch'</b>")

@app.route("/<user>/<repo>")
def get_latest_release(user, repo):
    url = f"https://api.github.com/repos/{user}/{repo}/releases/latest"
    try:
        response = requests.get (url)
        response.raise_for_status()
    except requests.exceptions.HTTPError as e:
        return(f"'user': {user} OR 'repository': {repo} are Not valid/exsits<br>Try again, For example: <b>'http://[IP]/elastic/elasticsearch'</b>")
    except requests.exceptions.RequestException as e:
        return(e.args[0])
    response_json = response.json()
    return(f"The latest release verion for user <b>'{user}'</b> AND repository <b>'{repo}'</b> is: <b>{response_json['tag_name']}</b>")

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)
