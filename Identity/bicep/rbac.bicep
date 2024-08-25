targetScope = 'managementGroup'

param environment string
param entraIdGroupOwners array
param topLevelManagementGroupName string

module entraIdGroupReaders 'modules/groups.bicep' = {
  name: 'entra-readers'
  params: {
    displayName: 'azurePlatform-readers-${environment}'
    owners: entraIdGroupOwners
  }
}

param azurePlatformProdPrincipalId string

module rbac 'modules/roleAssignment.bicep' = {
  name: 'rbac-AzureManagementProd'
  scope: managementGroup(topLevelManagementGroupName)
  params: {
    principlesId: azurePlatformProdPrincipalId
    roleDefinitions: [
      '/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'
      '/providers/Microsoft.Authorization/roleDefinitions/adb29209-aa1d-457b-a786-c913953d2891'
      '/providers/Microsoft.Authorization/roleDefinitions/18d7d88d-d35e-4fb5-a5c3-7773c20a72d9'
    ]
  }
}
