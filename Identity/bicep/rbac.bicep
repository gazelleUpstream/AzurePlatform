targetScope = 'managementGroup'

param environment string
param entraIdGroupOwners array

module entraIdGroupReaders 'modules/groups.bicep' = {
  name: 'entra-readers'
  params: {
    displayName: 'azurePlatform-readers-${environment}'
    owners: entraIdGroupOwners
  }
}


param azurePlatformTestPrincipalId string

module rbac 'modules/roleAssignment.bicep' = {
  name: 'rbac-to-move-subscription'
  scope: managementGroup('playground-${environment}')
  params: {
    principlesId: azurePlatformTestPrincipalId
    roleDefinitions: [
      '/providers/Microsoft.Authorization/roleDefinitions/5d58bcaf-24a5-4b20-bdb6-eed9f69fbe4c'
    ]
  }
}
