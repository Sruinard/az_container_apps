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


To work, configure Azure Container Apps in the following way:
- Internal applications should have their DAPR APP Port set to the same port number as the application app port. Otherwise your application won't start.
- There can only be one application with external ingress configured AND using DAPR for service invocation. This application should have the DAPR PORT set to 3500 and the application port to a port that is NOT equal to 3500.

