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
  // landingzone: {
  //   federatedCredentials: {
  //     github: {
  //       audiences: ['api://AzureADTokenExchange']
  //       issuer: 'https://token.actions.githubusercontent.com'
  //       subject: 'repo:gazelle-cloud/lz:environment:test'
  //     }
  //   }
  // }
}
