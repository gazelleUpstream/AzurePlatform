targetScope = 'managementGroup'

param policyName string = 'foo'
param displayName string = 'foo'
param favPolicyValue string
param laEffect string
param diagnosticSettingName string
param categoryGroup string
param logAnalytics string
param identityResoruceId string
param location string

var shortenPolicyName = take(policyName, 24)

var randomCucstomDfinition = loadJsonContent('customDefinitions/st_vnetAclrRules.json')

module customDefinition '../bicep/modules/policyDefinitions.bicep' = {
  name: 'definition-${policyName}-vnetRules'
  params: {
    policyName: randomCucstomDfinition.name
    policyProperties: randomCucstomDfinition.properties
  }
}

module setDefinition '../bicep/modules/policySetDefinitions.bicep' = {
  name: 'setDefinition-${policyName}'
  params: {
    policyName: shortenPolicyName
    displayName: displayName
    setDefinitions: [
      {
        policyDefinitionId: customDefinition.outputs.resourcrId
        policyDefinitionReferenceId: customDefinition.outputs.name
        parameters: {
          effect: {
            value: favPolicyValue
          }
        }
      }
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
