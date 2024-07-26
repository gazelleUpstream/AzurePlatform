targetScope = 'managementGroup'

param customDefinitions array

@batchSize(20)
module definitions 'modules/policyDefinitions.bicep' = [
  for item in customDefinitions: {
    name: 'definition-${item.name}'
    params: {
      policyName: item.name
      policyProperties: item.properties
    }
  }
]
