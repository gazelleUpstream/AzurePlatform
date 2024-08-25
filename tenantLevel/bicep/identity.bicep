targetScope = 'managementGroup'

param azurePlatformPrincipalId string
param roleDefinitions array

module rbac 'modules/roleAssignments.bicep' = {
  name: 'init-rbac'
  params: {
    principlesId: azurePlatformPrincipalId
    roleDefinitions: roleDefinitions
  }
}
