targetScope = 'subscription'

param workloadName string
param environment string
param federatedCredentials object
param location string

func repos(name string, githubOrganizationName string, githubRepoName string, environment string) object => {
  name: name
  audiences: [
    'api://AzureADTokenExchange'
  ]
  issuer: 'https://token.actions.githubusercontent.com'
  subject: 'repo:${githubOrganizationName}/${githubRepoName}:environment:${environment}'
}
var federatedCredentialsLoop = [
  for item in items(federatedCredentials): repos(item.key, item.value.org, item.value.repo, item.value.env)
]

resource IdentityRG 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: '${workloadName}-${environment}'
  location: location
}

module AzureIdentity 'br/public:avm/res/managed-identity/user-assigned-identity:0.2.1' = {
  name: 'AzureIdentity-${environment}'
  scope: IdentityRG
  params: {
    name: 'id-AzureIdentity-${environment}'
    federatedIdentityCredentials: federatedCredentialsLoop
  }
}

output AzureIdentityResourceId string = AzureIdentity.outputs.resourceId
output AzureIdentityObjectId string = AzureIdentity.outputs.principalId
output AzureIdentityClientId string = AzureIdentity.outputs.clientId
