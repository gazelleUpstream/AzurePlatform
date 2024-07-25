targetScope = 'managementGroup'

param location string
param policyName string
param policyProperties object
param identityResourceId string

resource setdefinition 'Microsoft.Authorization/policySetDefinitions@2023-04-01' = {
  name: policyName
  properties: policyProperties
}

resource ass 'Microsoft.Authorization/policyAssignments@2024-04-01' = {
  name: policyName
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${identityResourceId}': {}
    }
  }
  location: location
  properties: {
    policyDefinitionId: setdefinition.id
  }
}
