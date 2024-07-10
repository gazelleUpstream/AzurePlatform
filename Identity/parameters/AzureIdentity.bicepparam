using '../bicep/AzureIdentity.bicep'

param location = 'francecentral'
param environment = 'tst'
param workloadName = 'identity'
param subscriptionId = ''
param identity = {
  policy: {
    federatedCredentials: {}
  }
  // landingzone: {
  //   federatedCredentials: {
  //     github: {
  //       audiences: ['api://AzureADTokenExchange']
  //       issuer: 'https://token.actions.githubusercontent.com'
  //       subject: 'repo:gazelle-cloud/lz:environment:test'
  //     }
  //   }
  //   RBAC: {
  //     scope: 'online-test'
  //     roleDefinitions: [
  //       '/providers/Microsoft.Authorization/roleDefinitions/7f951dda-4ed3-4680-a7ca-43fe172d538d'
  //     ]
  //   }
  // }
}
