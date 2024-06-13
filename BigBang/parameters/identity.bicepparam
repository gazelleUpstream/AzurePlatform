using '../bicep/main-identity.bicep'

param workloadName = 'Identity'

param federatedCredentials = {
  AzureIdentity: {
    org: 'gazelle-cloud'
    repo: 'azurePlatform'
    env: '${environment}-Identity'
  }
}

// these values are fetched from the GitHub variables
param environment = ''
param location = ''
