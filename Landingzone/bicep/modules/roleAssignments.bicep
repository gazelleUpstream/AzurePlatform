targetScope  = 'subscription'

param principalId string
param rbacId array

resource rbacAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = [for item in rbacId: {
  name: guid(item, principalId, subscription().id)
  properties: {
    principalId: principalId
    roleDefinitionId: item
    principalType: 'ServicePrincipal'
  }
}]
