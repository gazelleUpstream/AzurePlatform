targetScope = 'managementGroup'

param listOfAllowedLocations array
param identityResoruceId string
param location string

module setDefinition '../bicep/modules/policySetDefinitions.bicep' = {
  name: 'policy-allowed-location'
  params: {
    policyName: 'allowed-location'
    setDeinitions: [
      {
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c'
        policyDefinitionReferenceId: 'allowedResourceLocations'
        parameters: {
          listOfAllowedLocations: {
            value: listOfAllowedLocations
          }
        }
      }
      {
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/e765b5de-1225-4ba3-bd56-1ac6695af988'
        policyDefinitionReferenceId: 'allowedResourceGroupLocations'
        parameters: {
          listOfAllowedLocations: {
            value: listOfAllowedLocations
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
