targetScope = 'managementGroup'

param policyName string = 'allowedLocations'
param displayName string = 'allowed Locations'
param listOfAllowedLocations array
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
  name: 'assignment-${policyName}'
  params: {
    policyName: shortenPolicyName
    displayName: displayName
    location: location
    identityResourceId: identityResoruceId
    setDefinitionId: setDefinition.outputs.resourceId
  }
}
