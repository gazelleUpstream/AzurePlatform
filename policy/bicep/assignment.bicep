targetScope = 'managementGroup'

param policies array
param location string
param identityResoruceId string

module assinments 'modules/policy.bicep' = [
  for item in policies: {
    name: 'policy-${item.name}'
    params: {
      location: location
      identityResourceId: identityResoruceId
      policyName: item.name
      policyProperties: item.properties
    }
  }
]
