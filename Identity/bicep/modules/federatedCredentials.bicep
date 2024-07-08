param userAssignedIdentityName string

param federatedCredentials object

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' existing = {
  name: userAssignedIdentityName
}

@batchSize(1)
resource federatedIdentityCredential 'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2023-01-31' = [
  for item in items(federatedCredentials): {
    name: item.key
    parent: userAssignedIdentity
    properties: item.value
  }
]
