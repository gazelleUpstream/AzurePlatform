targetScope = 'managementGroup'

param policyName string

param setDeinitions setDefinitionsType


resource initiative 'Microsoft.Authorization/policySetDefinitions@2023-04-01' = {
  name: policyName
  properties: {
    policyDefinitions: setDeinitions
  }
}


type setDefinitionsType = {
    policyDefinitionId: string
    policyDefinitionReferenceId: string
    parameters: object
  }[]

output resourceId string = initiative.id
output name string = initiative.name
