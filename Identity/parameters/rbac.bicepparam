using '../bicep/rbac.bicep'

param environment = readEnvironmentVariable('managementGroupHierarchy', '')
param azurePlatformProdPrincipalId = readEnvironmentVariable('AZURE_PLATFORM_PROD_PRINCIPAL_ID', '')
param topLevelManagementGroupName = readEnvironmentVariable('TOP_LEVEL_MANAGEMENTGROUP_NAME', '')
param entraIdGroupOwners = [
  '0d6eb039-8df3-4a3d-a4f4-05254113fb9a'
]

