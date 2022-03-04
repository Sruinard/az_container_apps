# az_container_apps
Getting started with Azure Container Apps


Deploy two microservices and invoke other service by using DAPR.
The services can be found in:
- checkout-service
- sessions

to run this example locally:
- install tye https://github.com/dotnet/tye/blob/main/docs/getting_started.md
- create virtualenv `$python -m venv venv`
- activate virtualenv: `$source venv/bin/activate`
- install requirements: `pip install -r requirements.txt`
- run `tye run` from root directory

container-envs.sh contains logic for running/updating azure container apps.


usefull resources:

https://blog.johnnyreilly.com/2022/01/22/azure-container-apps-dapr-bicep-github-actions-debug-devcontainer

https://github.com/Azure-Samples/container-apps-store-api-microservice


