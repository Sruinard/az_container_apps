 az deployment group create -g dapr-raitora-container -f ./infra/main.bicep \
             -p \
                containerRegistry="appdapr.azurecr.io" \
                containerRegistryUsername="appdapr" \
                containerRegistryPassword="SplCw5fWjk9QEyKGf+sf9qzFswstE5VD"