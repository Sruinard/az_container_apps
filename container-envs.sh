#!/bin/bash
RESOURCE_GROUP="dapr-raitora-container"
LOCATION="westeurope"
LOG_ANALYTICS_WORKSPACE="laws-raitora"
CONTAINERAPPS_ENVIRONMENT="dapr-raitora-env"


CONTAINER_IMAGE_NAME="management-plane"
REGISTRY_LOGIN_SERVER="appdapr.azurecr.io"
REGISTRY_USERNAME="appdapr"
REGISTRY_PASSWORD="SplCw5fWjk9QEyKGf+sf9qzFswstE5VD"

az containerapp create  --name management-plane-app  --resource-group dapr-raitora-container  --image "appdapr.azurecr.io/management-plane:latest"  --environment "dapr-raitora-env"   --registry-login-server "appdapr.azurecr.io"  --registry-username "appdapr"  --registry-password "SplCw5fWjk9QEyKGf+sf9qzFswstE5VD"  --target-port 3000  --ingress 'external' --cpu 1.5 --memory 3.0Gi  --min-replicas 1 --max-replicas 1 --enable-dapr  --dapr-app-port 3000  --dapr-app-id management-plane-app  
az containerapp update  --name management-plane-app  --resource-group dapr-raitora-container  --image "appdapr.azurecr.io/management-plane:latest"   --registry-login-server "appdapr.azurecr.io"  --registry-username "appdapr"  --registry-password "SplCw5fWjk9QEyKGf+sf9qzFswstE5VD"  --target-port 3000  --ingress 'external' --cpu 1.5 --memory 3.0Gi  --min-replicas 1 --max-replicas 1  --enable-dapr  --dapr-app-port 3500  --dapr-app-id management-plane-app 


az containerapp create -n sessions-app  -g dapr-raitora-container  --image "appdapr.azurecr.io/sessions:latest"  --environment "dapr-raitora-env"   --registry-login-server "appdapr.azurecr.io"  --registry-username "appdapr"  --registry-password "SplCw5fWjk9QEyKGf+sf9qzFswstE5VD"  --target-port 5000 --ingress "internal" --cpu 1.5 --memory 3.0Gi  --min-replicas 1 --max-replicas 1 --enable-dapr  --dapr-app-port 5000  --dapr-app-id sessions-app 
az containerapp update -n sessions-app  -g dapr-raitora-container  --image "appdapr.azurecr.io/sessions:latest"   --registry-login-server "appdapr.azurecr.io"  --registry-username "appdapr"  --registry-password "SplCw5fWjk9QEyKGf+sf9qzFswstE5VD"  --target-port 5000  --ingress 'external'  --cpu 1.5 --memory 3.0Gi  --min-replicas 1 --max-replicas 1 --enable-dapr  --dapr-app-port 3501  --dapr-app-id sessions-app 