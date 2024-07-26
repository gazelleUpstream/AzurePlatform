targetScope = 'managementGroup'

param policies array
param location string
param identityResoruceId string
#disable-next-line no-unused-params
param environment string
#disable-next-line no-unused-params
param topLevelManagementGroupName string

module assinments 'modules/assignment.bicep' = [
  for item in policies: {
    name: 'policy-${item.name}'
    params: {
      location: location
      identityResourceId: identityResoruceId
      policyName: item.name
      builtInProperties: item.builtIn
    }
  }
]
