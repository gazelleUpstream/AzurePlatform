using '../bicep/rbac.bicep'

param environment = readEnvironmentVariable('managementGroupHierarchy', '')
param azurePlatformTestPrincipalId = readEnvironmentVariable('AZURE_PLATFORM_TEST_PRINCIPAL_ID', '')
param entraIdGroupOwners = [
  '0d6eb039-8df3-4a3d-a4f4-05254113fb9a'
]

