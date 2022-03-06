
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

DAPR_APP_PORT = os.environ.get("DAPR_HTTP_PORT", 3503)
APP_PORT = os.getenv("CONTAINER_APP_PORT", 5000)
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
    return "The sessions API responsible for checkouts."

@app.get("/info")
def checkout_info():
    checkout_data = {
        "app-port": APP_PORT,
        "dapr-port": DAPR_APP_PORT

    }
    return checkout_data, os.environ

@app.get("/checkout-profile")
def obtain_available_chargers():
    res = requests.get("http://localhost:{}/customers".format(DAPR_APP_PORT), headers={"dapr-app-id": "customer-app"})
    return res.json()

@app.get("/checkouts")
def create_sessions():
    return [{"checkout_id": "12345", "amount": "9999"}, {"checkout_id": "123", "amount": "42"}]

@app.get("/history")
def obtain_available_chargers():
    res = requests.get("http://localhost:{}/v1.0/invoke/sessions-app/method/vehiclesdata".format(DAPR_APP_PORT))
    return res.json()

@app.get("/history-headers")
def obtain_available_chargers():
    res = requests.get("http://localhost:{}/vehiclesdata".format(DAPR_APP_PORT), headers={"dapr-app-id": "sessions-app"})
    return res.json()

@app.get("/history-headers-post")
def obtain_available_chargers():
    res = requests.post("http://localhost:{}/vehiclesdata".format(DAPR_APP_PORT), headers={"dapr-app-id": "sessions-app"})
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
    # run_app()

    uvicorn.run(app, host="0.0.0.0", port=APP_PORT)
    