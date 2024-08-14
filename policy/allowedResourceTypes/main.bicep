targetScope = 'managementGroup'

param policyName string = 'allowedResourceTypes'
param displayName string = 'allowed resource types'
param listOfResourceTypesAllowed array
param identityResoruceId string
param location string

var shortenPolicyName = take(policyName, 24)

module setDefinition '../bicep/modules/policySetDefinitions.bicep' = {
  name: 'initiative-${policyName}'
  params: {
    policyName: shortenPolicyName
    displayName: displayName
    setDefinitions: [
      {
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/a08ec900-254a-4555-9bf5-e42af04b5c5c'
        policyDefinitionReferenceId: 'allowedResources'
        parameters: {
          listOfResourceTypesAllowed: {
            value: listOfResourceTypesAllowed
          }
        }
      }
    ]
  }
}

module assignment '../bicep/modules/policyAssignments.bicep' = {
  name: 'assignment-${policyName}'
  params: {
    policyName: shortenPolicyName
    displayName: displayName
    location: location
    identityResourceId: identityResoruceId
    setDefinitionId: setDefinition.outputs.resourceId
  }
}
