
import gunicorn.app.base
import multiprocessing
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import requests
import os

import logging
logger = logging.getLogger()
logging.basicConfig(level=logging.WARNING)

DAPR_APP_PORT = os.environ.get("DAPR_HTTP_PORT", 3502)
APP_PORT = os.getenv("PORT", 3000)

def number_of_workers():
    return (multiprocessing.cpu_count() * 2) + 1


class GunicornRuntimeApplication(gunicorn.app.base.BaseApplication):

    def __init__(self, app, options=None):
        self.options = options or {}
        self.application = app
        super().__init__()

    def load_config(self):
        config = {key: value for key, value in self.options.items()
                  if key in self.cfg.settings and value is not None}
        for key, value in config.items():
            self.cfg.set(key.lower(), value)

    def load(self):
        return self.application


app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
def homepage():
    return "The sessions API responsible for booking a session."


@app.get("/sessions")
def create_sessions():
    return [{"session_id": "123", "location": "Utrecht", "type": "CCS"}]

@app.get("/payments")
def obtain_available_chargers():
    res = requests.get("http://localhost:{}/v1.0/invoke/checkout-app/method/checkouts".format(DAPR_APP_PORT))
    return res.json()

@app.get("/payments-headers")
def obtain_available_chargers():
    res = requests.get("http://localhost:{}/checkouts".format(DAPR_APP_PORT), headers={"dapr-app-id": "checkout-app"})
    return res.json()

@app.get("/payments-headers-post")
def obtain_available_chargers():
    res = requests.post("http://localhost:{}/checkouts".format(DAPR_APP_PORT), headers={"dapr-app-id": "checkout-app"})
    return res.json()

def run_app():
    options = {
        "bind": "0.0.0.0:{}".format(APP_PORT),
        "workers": 4,
        "accesslog": "-",
        "errorlog": "-",
        "worker_class": "uvicorn.workers.UvicornWorker",
    }
    GunicornRuntimeApplication(app, options).run()


if __name__ == "__main__":
    run_app()
