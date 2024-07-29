using '../bicep/main.bicep'

param workloadName = 'monitoring'
param environment = readEnvironmentVariable('environment', '')
param location = readEnvironmentVariable('AZURE_DEFAULT_LOCATION', '')
