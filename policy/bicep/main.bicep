targetScope = 'managementGroup'

param scopes array
param location string
param policies array
param identityResoruceId string
param environment string

module ass 'assignment.bicep' = [
  for item in scopes: {
    name: 'policy-${item}'
    scope: managementGroup(item)
    params: {
      identityResoruceId: identityResoruceId
      location: location
      policies: policies
    }
  }
]
