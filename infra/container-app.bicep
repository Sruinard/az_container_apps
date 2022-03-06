param containerAppName string
param location string = resourceGroup().location
param environmentId string
param containerImage string
param containerPort int
param daprAppPort int
param isExternalIngress bool
param containerRegistry string
param containerRegistryUsername string
param env array = []
param daprComponents array = []
param minReplicas int = 1
param secrets array = [
  {
    name: 'docker-password'
    value: containerRegistryPassword
  }
]

@secure()
param containerRegistryPassword string

var cpu = json('1.5')
var memory = '3Gi'
var registrySecretRefName = 'docker-password'

resource containerApp 'Microsoft.Web/containerApps@2021-03-01' = {
  name: containerAppName
  kind: 'containerapp'
  location: location
  properties: {
    kubeEnvironmentId: environmentId
    configuration: {
      secrets: secrets
      registries: [
        {
          server: containerRegistry
          username: containerRegistryUsername
          passwordSecretRef: registrySecretRefName
        }
      ]
      ingress: {
        external: isExternalIngress
        targetPort: containerPort
        transport: 'auto'
      }
    }
    template: {
      containers: [
        {
          image: containerImage
          name: containerAppName
          env: env
          resources: {
            cpu: cpu
            memory: memory
          }
        }
      ]
      scale: {
        minReplicas: minReplicas
      }
      dapr: {
        enabled: true
        appPort: daprAppPort
        appId: containerAppName
        components: daprComponents
      }
    }
  }
}

output fqdn string = containerApp.properties.configuration.ingress.fqdn
