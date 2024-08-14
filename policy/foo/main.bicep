import * as myImports from '../bicep/modules/assignment.bicep'

targetScope = 'managementGroup'

param policyName string = 'foo'
param displayName string = 'foo bar'
param laEffect string
param diagnosticSettingName string
param categoryGroup string
param logAnalytics string
param identityResoruceId string
param location string

param initiatives myImports.setDefinitionsType = [
    {
      policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/818719e5-1338-4776-9a9d-3c31e4df5986'
      policyDefinitionReferenceId: 'logAnalytics'
      parameters: {
        effect: {
          value: laEffect
        }
        diagnosticSettingName: {
          value: diagnosticSettingName
        }
        categoryGroup: {
          value: categoryGroup
        }
        logAnalytics: {
          value: logAnalytics
        }
      }
    }
]

module goHome '../bicep/modules/assignment.bicep' = {
  name: 'policy-${policyName}'
  params: {
    policyName: policyName
    displayName: displayName
    location: location
    identityResourceId: identityResoruceId
    setDefinitions: initiatives
  }
}
