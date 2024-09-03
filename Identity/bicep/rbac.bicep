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

var rbacMapping = loadJsonContent('../../AzureRoleDefinitions.json')

module rbac 'modules/roleAssignment.bicep' = {
  name: 'rbac-AzureManagementProd'
  scope: managementGroup(topLevelManagementGroupName)
  params: {
    principlesId: entraIdGroupReaders.outputs.groupObjectId
    principalType: 'Group'
    roleDefinitions: [
      rbacMapping.Reader
    ]
  }
}
