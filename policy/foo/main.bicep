targetScope = 'managementGroup'

param favPolicyValue string
// param anotherPolicyValue string
param laEffect string
param diagnosticSettingName string
param categoryGroup string
param logAnalytics string
param identityResoruceId string
param location string

var favoriteCustomPolicy = loadJsonContent('customDefinitions/st_vnetAclrRules.json')
// var anotherCoolPolicy = loadJsonContent('../parameters/customDefinitions/st_corssTenantReplication.json')

module favortitePolicy '../bicep/modules/policyDefinitions.bicep' = {
  name: 'my-favorite-custom-policy'
  params: {
    policyName: favoriteCustomPolicy.name
    policyProperties: favoriteCustomPolicy.properties
  }
}

// module anotherPolicy 'modules/policyDefinitions.bicep' = {
//   name: 'another-cool-policy'
//   params: {
//     policyName: anotherCoolPolicy.name
//     policyProperties: anotherCoolPolicy.properties
//   }
// }

module setDefinition '../bicep/modules/policySetDefinitions.bicep' = {
  name: 'my-custom-init'
  params: {
    policyName: 'something-cool'
    setDeinitions: [
      {
        policyDefinitionId: favortitePolicy.outputs.resourcrId
        policyDefinitionReferenceId: favortitePolicy.outputs.name
        parameters: {
          effect: {
            value: favPolicyValue
          }
        }
      }
      // {
      //   policyDefinitionId: anotherPolicy.outputs.resourcrId
      //   policyDefinitionReferenceId: anotherPolicy.outputs.name
      //   parameters: {
      //     effect: {
      //       value: anotherPolicyValue
      //     }
      //   }
      // }
      {
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/fea83f6c-a18a-4338-8f1f-80ecba4c5643'
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
  name: 'my-facorite-policy'
  params: {
    policyName: setDefinition.outputs.name
    displayName: setDefinition.outputs.name
    location: location
    identityResourceId: identityResoruceId
    setDefinitionId: setDefinition.outputs.resourceId
  }
}
