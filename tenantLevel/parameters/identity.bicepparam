using '../bicep/identity.bicep'

param azurePlatformPrincipalId = readEnvironmentVariable('AZURE_PLATFORM_PRINCIPAL_ID', '')
param roleDefinitions = [
  '/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'
  '/providers/Microsoft.Authorization/roleDefinitions/18d7d88d-d35e-4fb5-a5c3-7773c20a72d9'
]
