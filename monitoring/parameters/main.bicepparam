using '../bicep/main.bicep'

param workloadName = 'monitoring'
param environment = readEnvironmentVariable('managementGroupHierarchy', '')
param location = readEnvironmentVariable('AZURE_DEFAULT_LOCATION', '')
