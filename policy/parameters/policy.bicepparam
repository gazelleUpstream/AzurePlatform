using '../bicep/main.bicep'

param identityResoruceId = readEnvironmentVariable('POLICY_RESOURCE_ID', '')
param location = readEnvironmentVariable('AZURE_DEFAULT_LOCATION', '')
param environment = readEnvironmentVariable('environment', '')
param scopes = [
  'online-${environment}'
]
param policies = [
  loadJsonContent('allowedLocations.json')
]
