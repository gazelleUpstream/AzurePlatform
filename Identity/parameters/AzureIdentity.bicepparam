using '../bicep/AzureIdentity.bicep'

param workloadName = 'identity'
param location = readEnvironmentVariable('AZURE_DEFAULT_LOCATION', '')
param environment = readEnvironmentVariable('environment', '')
param subscriptionId = readEnvironmentVariable('MANAGEMENT_SUBSCRIPTION_ID', '')
param identity = {
  policy: {
    federatedCredentials: {}
    RBAC: {
      scope: 'gazelle-${environment}'
      roleDefinitions: [
        '/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'
      ]
    }
  }
  landingzones: {
    federatedCredentials: {
      github: {
        audiences: ['api://AzureADTokenExchange']
        issuer: 'https://token.actions.githubusercontent.com'
        subject: 'repo:gazelle-cloud/AzurePlatform:environment:${environment}-AzurePlatform'
      }
    }
    RBAC: {
      scope: 'gazelle-${environment}'
      roleDefinitions: [
        '/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'
        '/providers/Microsoft.Authorization/roleDefinitions/18d7d88d-d35e-4fb5-a5c3-7773c20a72d9'
        '/providers/Microsoft.Authorization/roleDefinitions/adb29209-aa1d-457b-a786-c913953d2891'
      ]
    }
  }
}
