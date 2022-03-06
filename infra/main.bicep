param location string = resourceGroup().location
param environmentName string = 'dapr-raitora-ddd'

param minReplicas int = 1

param sessionsImage string = 'appdapr.azurecr.io/sessions:latest'
param sessionsPort int = 3000
param isSessionsExternalIngress bool = true
param sessionsDaprPort int = 3500
param sessionAppName string = 'sessions-app'

param checkoutServiceImage string = 'appdapr.azurecr.io/checkout-service:latest'
param checkoutServicePort int = 5000
param isCheckoutServiceExternalIngress bool = false
param checkoutServiceDaprPort int = 5000
param checkoutServiceAppName string = 'checkout-app'

param customerAppImage string = 'appdapr.azurecr.io/profile:latest'
param customerAppPort int = 4000
param isCustomerAppExternalIngress bool = false
param customerAppDaprPort int = 4000
param customerAppName string = 'customer-app'

param containerRegistry string
param containerRegistryUsername string

@secure()
param containerRegistryPassword string

// // container app environment
module environment 'container-env.bicep' = {
  name: 'container-app-environment'
  params: {
    environmentName: environmentName
    location: location
  }
}

// Python App
module sessionsAPI 'container-app.bicep' = {
  name: sessionAppName
  params: {
    location: location
    containerAppName: sessionAppName
    environmentId: environment.outputs.environmentId
    containerImage: sessionsImage
    containerPort: sessionsPort
    daprAppPort: sessionsDaprPort
    isExternalIngress: isSessionsExternalIngress
    minReplicas: minReplicas
    containerRegistry: containerRegistry
    containerRegistryUsername: containerRegistryUsername
    containerRegistryPassword: containerRegistryPassword
    secrets: [
      {
        name: 'docker-password'
        value: containerRegistryPassword
      }
    ]
  }
}

// Python App
module checkoutAPI 'container-app.bicep' = {
  name: checkoutServiceAppName
  params: {
    location: location
    containerAppName: checkoutServiceAppName
    environmentId: environment.outputs.environmentId
    containerImage: checkoutServiceImage
    containerPort: checkoutServicePort
    daprAppPort: checkoutServiceDaprPort
    isExternalIngress: isCheckoutServiceExternalIngress
    minReplicas: minReplicas
    containerRegistry: containerRegistry
    containerRegistryUsername: containerRegistryUsername
    containerRegistryPassword: containerRegistryPassword
    secrets: [
      {
        name: 'docker-password'
        value: containerRegistryPassword
      }
    ]
  }
}

// Python App
module customerAPI 'container-app.bicep' = {
  name: customerAppName
  params: {
    location: location
    containerAppName: customerAppName
    environmentId: environment.outputs.environmentId
    containerImage: customerAppImage
    containerPort: customerAppPort
    daprAppPort: customerAppDaprPort
    isExternalIngress: isCustomerAppExternalIngress
    minReplicas: minReplicas
    containerRegistry: containerRegistry
    containerRegistryUsername: containerRegistryUsername
    containerRegistryPassword: containerRegistryPassword
    secrets: [
      {
        name: 'docker-password'
        value: containerRegistryPassword
      }
    ]
  }
}
