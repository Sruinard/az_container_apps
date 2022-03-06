
import gunicorn.app.base
import multiprocessing
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import requests
import os
import uvicorn

import logging
logger = logging.getLogger()
logging.basicConfig(level=logging.WARNING)

DAPR_APP_PORT = os.environ.get("DAPR_HTTP_PORT", 3504)
APP_PORT = os.getenv("CONTAINER_APP_PORT", 4000)
if os.getenv("PORT"):
    APP_PORT = os.getenv("PORT")

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
    return "the customer api"

@app.get("/info")
def checkout_info():
    checkout_data = {
        "app-port": APP_PORT,
        "dapr-port": DAPR_APP_PORT

    }
    return checkout_data, os.environ

@app.get("/customers")
def create_sessions():
    return [{"customer_id": "123"}]

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
    # run_app()

    uvicorn.run(app, host="0.0.0.0", port=APP_PORT)
    