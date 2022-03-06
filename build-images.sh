docker build -t checkout-service ./checkout-service
docker tag checkout-service appdapr.azurecr.io/checkout-service
docker push appdapr.azurecr.io/checkout-service

docker build -t sessions ./sessions
docker tag sessions appdapr.azurecr.io/sessions
docker push appdapr.azurecr.io/sessions

docker build -t profile ./profile
docker tag profile appdapr.azurecr.io/profile
docker push appdapr.azurecr.io/profile