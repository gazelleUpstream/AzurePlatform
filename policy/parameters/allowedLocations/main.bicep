import * as definitions from '../../bicep/modules/assignment.bicep'

targetScope = 'managementGroup'

param policyName string = 'allowedLocations'
param displayName string = 'allowed locations'
param location string = deployment().location
param identityResoruceId string
param listOfAllowedLocations array = [
  location
]
#disable-next-line no-unused-params
param topLevelManagementGroupName string

param initiatives definitions.setDefinitionsType = [
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

module assignment '../../bicep/modules/assignment.bicep' = {
  name: 'policy-${policyName}'
  params: {
    policyName: policyName
    displayName: displayName
    location: location
    identityResourceId: identityResoruceId
    setDefinitions: initiatives
  }
}
