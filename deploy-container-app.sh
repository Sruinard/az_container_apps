az containerapp create  \
--name checkout-app \
--resource-group dapr-raitora-container \
--image "appdapr.azurecr.io/checkout-service:latest" \
--environment "dapr-raitora-env" \
--registry-login-server "appdapr.azurecr.io" \
--registry-username "appdapr" \
--registry-password "SplCw5fWjk9QEyKGf+sf9qzFswstE5VD"  \
--target-port 5000  \
--ingress 'internal' \
--cpu 1.5 \
--memory 3.0Gi \
--min-replicas 1 \
--max-replicas 1 \
--enable-dapr \
--dapr-app-port 5000 \
--dapr-app-id checkout-app

az containerapp create  \
--name customer-app \
--resource-group dapr-raitora-container \
--image "appdapr.azurecr.io/profile:latest" \
--environment "dapr-raitora-env" \
--registry-login-server "appdapr.azurecr.io" \
--registry-username "appdapr" \
--registry-password "SplCw5fWjk9QEyKGf+sf9qzFswstE5VD"  \
--target-port 4000  \
--ingress 'internal' \
--cpu 1.5 \
--memory 3.0Gi \
--min-replicas 1 \
--max-replicas 1 \
--enable-dapr \
--dapr-app-port 4000 \
--dapr-app-id customer-app


az containerapp create  \
--name sessions-app \
--resource-group dapr-raitora-container \
--image "appdapr.azurecr.io/sessions:latest" \
--environment "dapr-raitora-env" \
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