targetScope = 'managementGroup'

param policyName string
param displayName string
param location string
param identityResourceId string
param setDefinitions setDefinitionsType

var shortenPolicyName = take(policyName, 24)

resource initiative 'Microsoft.Authorization/policySetDefinitions@2023-04-01' = {
  name: shortenPolicyName
  properties: {
    displayName: displayName
    policyDefinitions: setDefinitions
  }
}

resource assignment 'Microsoft.Authorization/policyAssignments@2024-04-01' = {
  name: shortenPolicyName
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${identityResourceId}': {}
    }
  }
  location: location
  properties: {
    policyDefinitionId: initiative.id
    displayName: displayName
  }
}
@export()
type setDefinitionsType = {
  policyDefinitionId: string
  policyDefinitionReferenceId: string
  parameters: object
}[]
