targetScope  = 'subscription'

param params object

var resourceTags = {
  labName: params.labName
  environment: params.environment
}

module identity 'modules/identity.bicep' = {
  name: 'lz-serviceConnectionIdentity'
  params: {
    labName: params.labName
    environment: params.environment
    location: params.location
    githubOrganizationName: params.githubOrganizationName
    githubRepoName: params.githubRepoName
  }
}

module resourceLevelTags 'modules/policyAssignment.bicep' = [
  for item in items(resourceTags): {
    name: 'lz-tag-${item.key}'
    params: {
      name: 'tag-${item.key}'
      location: params.location
      displayName: 'tag: ${item.key}'
      identityResourceId: identity.outputs.resourceId
      policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/4f9dc7db-30c1-420c-b61a-e1d640128d26'
      parameters: {
        tagName: {
          value: item.key
        }
        tagValue: {
          value: item.value
        }
      }
    }
  }
]



module securityContacts 'modules/securityContacts.bicep' = {
  name: 'lz-security-contacts'
}

output gitHubEnviromentVariables object = {
  serviceConnection_client_Id: identity.outputs.clientId
}
