FROM python:3.9

WORKDIR /src
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .

EXPOSE 5000
# CMD [ "python", "-m", "sessions.entrypoints.api" ]
CMD [ "python", "api.py" ]