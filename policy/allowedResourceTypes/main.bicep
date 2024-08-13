targetScope = 'managementGroup'

param listOfResourceTypesAllowed array
param identityResoruceId string
param location string

module setDefinition '../bicep/modules/policySetDefinitions.bicep' = {
  name: 'policy-allowed-Resource-Types'
  params: {
    policyName: 'allowed-resource-types'
    setDeinitions: [
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
  name: 'my-facorite-policy'
  params: {
    policyName: setDefinition.outputs.name
    displayName: setDefinition.outputs.name
    location: location
    identityResourceId: identityResoruceId
    setDefinitionId: setDefinition.outputs.resourceId
  }
}
