targetScope = 'managementGroup'

param policyName string
param identityResourceId string
param location string
param setDefinitionId string
param displayName string

resource assignment 'Microsoft.Authorization/policyAssignments@2024-04-01' = {
  name: policyName
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${identityResourceId}': {}
    }
  }
  location: location
  properties: {
    policyDefinitionId: setDefinitionId
    displayName: displayName
    parameters: {}
  }
}
