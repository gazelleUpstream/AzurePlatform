targetScope = 'subscription'

param labName string
param environment string
param location string
param githubOrganizationName string
param githubRepoName string


resource landingzoneResourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: 'landingzone-resources'
  location: location
}

module identity 'br/public:avm/res/managed-identity/user-assigned-identity:0.2.1' = {
  scope: landingzoneResourceGroup
  name: 'lz-serviceConnection'
  params: {
    name: 'id-${labName}-${environment}'
    location: location
    federatedIdentityCredentials: [
      {
        name: 'landingzoneOwner'
        audiences: [
          'api://AzureADTokenExchange'
        ]
        issuer: 'https://token.actions.githubusercontent.com'
        subject: 'repo:${githubOrganizationName}/${githubRepoName}:environment:${environment}'
      }
    ]
  }
}

module rbacAdmin 'roleAssignments.bicep' = {
  name: 'lz-rbac-serviceConnection'
  params: {
    principalId: identity.outputs.principalId
    rbacId: [
      '/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'
      '/providers/Microsoft.Authorization/roleDefinitions/18d7d88d-d35e-4fb5-a5c3-7773c20a72d9'
    ]
  }
}

output clientId string = identity.outputs.clientId
output principalId string = identity.outputs.principalId
output resourceId string = identity.outputs.resourceId
