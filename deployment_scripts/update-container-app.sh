
az containerapp update  \
--name checkout-app \
--resource-group dapr-raitora-container \
--image "appdapr.azurecr.io/checkout-service:latest" \
--registry-login-server "appdapr.azurecr.io" \
--registry-username "appdapr" \
--registry-password "SplCw5fWjk9QEyKGf+sf9qzFswstE5VD"  \
--target-port 5000  \
--ingress 'external' \
--cpu 1.5 \
--memory 3.0Gi \
--min-replicas 1 \
--max-replicas 1 \
--enable-dapr \
--dapr-app-port 3501 \
--dapr-app-id checkout-app  


az containerapp update  \
--name sessions-app \
--resource-group dapr-raitora-container \
--image "appdapr.azurecr.io/sessions:latest" \
--registry-login-server "appdapr.azurecr.io" \
--registry-username "appdapr" \
--registry-password "SplCw5fWjk9QEyKGf+sf9qzFswstE5VD"  \
--target-port 3000  \
--ingress 'external' \
--cpu 1.5 \
--memory 3.0Gi \
--min-replicas 1 \
--max-replicas 1 \
--enable-dapr \
--dapr-app-port 3500 \
--dapr-app-id sessions-app  



