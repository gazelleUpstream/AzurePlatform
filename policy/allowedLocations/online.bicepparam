using 'main.bicep'

param identityResoruceId = readEnvironmentVariable('POLICY_RESOURCE_ID','')
param location = readEnvironmentVariable('AZURE_DEFAULT_LOCATION', '')
param listOfAllowedLocations = [
  'franceCentral'
]
