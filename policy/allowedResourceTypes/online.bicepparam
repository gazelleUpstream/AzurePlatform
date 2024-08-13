using 'main.bicep'

param identityResoruceId = readEnvironmentVariable('POLICY_RESOURCE_ID', '')
param location = readEnvironmentVariable('AZURE_DEFAULT_LOCATION', '')
param listOfResourceTypesAllowed = [
  'Microsoft.ManagedIdentity/userAssignedIdentities'
  'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials'
  'Microsoft.OperationalInsights/workspaces'
  'Microsoft.Resources/deploymentStacks'
  'Microsoft.Resources/resourceGroups'
  'Microsoft.Resources/tags'
]
