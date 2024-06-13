targetScope = 'subscription'

param workloadName string = 'Identity'
param environment string
param location string


resource IdentityRG 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: '${workloadName}-${environment}'
  location: location
}

module Policy 'br/public:avm/res/managed-identity/user-assigned-identity:0.2.1' = {
  name: 'Policy-${environment}'
  scope: IdentityRG
  params: {
    name: 'id-Policy-${environment}'
    federatedIdentityCredentials: [
      {
        name: 'Policy'
        audiences: [
          'api://AzureADTokenExchange'
        ]
        issuer: 'https://token.actions.githubusercontent.com'
        subject: 'repo:gazelle-cloud/AzurePlatform:environment:${environment}-Policy'
      }
    ]
  }
}

output PolicyResourceId string = Policy.outputs.resourceId
output PolicyObjectId string = Policy.outputs.principalId
output PolicyClientId string = Policy.outputs.clientId

module Landingzone 'br/public:avm/res/managed-identity/user-assigned-identity:0.2.1' = {
  name: 'Landingzone-${environment}'
  scope: IdentityRG
  params: {
    name: 'id-Landingzone-${environment}'
    federatedIdentityCredentials: [
      {
        name: 'Landingzone'
        audiences: [
          'api://AzureADTokenExchange'
        ]
        issuer: 'https://token.actions.githubusercontent.com'
        subject: 'repo:gazelle-cloud/AzurePlatform:environment:${environment}-Landingzone'
      }
    ]
  }
}

output LandingzoneResourceId string = Landingzone.outputs.resourceId
output LandingzoneObjectId string = Landingzone.outputs.principalId
output LandingzoneClientId string = Landingzone.outputs.clientId
