param workloadName string
param environment string
param federatedCredentials object
param location string = resourceGroup().location

var name = 'id-${workloadName}-${environment}'

resource identity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: name
  location: location
}

module fed 'federatedCredentials.bicep' = {
  name: 'fedCred-${identity.name}'
  params: {
    userAssignedIdentityName: identity.name
    federatedCredentials: federatedCredentials
  }
}

output principalId string = identity.properties.principalId
output clientId string = identity.properties.clientId
output resourceId string = identity.id
