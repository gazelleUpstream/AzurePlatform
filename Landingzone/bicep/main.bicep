targetScope = 'managementGroup'

param params object
param subscriptionId string

var subscriptionTags = {
  owner: params.ownerEmail
  engineer: params.engineer
}

var resourceTags = {
  labName: params.labName
  environment: params.environment
}

module identity 'modules/identity.bicep' = {
  name: 'lz-serviceConnectionIdentity'
  scope: subscription(subscriptionId)
  params: {
    labName: params.labName
    environment: params.environment
    location: params.location
    githubOrganizationName: params.githubOrganizationName
    githubRepoName: params.githubRepoName
  }
}

module tags 'modules/policyAssignment.bicep' = [
  for item in items(resourceTags): {
    name: 'lz-tag-${item.key}'
    scope: subscription(subscriptionId)
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

// module tagsOnSubscription 'br/public:avm/ptn/authorization/policy-assignment:0.1.0' = [
//   for item in items(subscriptionTags): {
//     name: 'tag-${item.key}'
//     params: {
//       name: 'tag-${item.key}'
//       displayName: 'tag: ${item.key}'
//       location: params.location
//       policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/61a4d60b-7326-440e-8051-9f94394d4dd1'
//       userAssignedIdentityId: identity.outputs.resourceId
//       subscriptionId: subscriptionId
//       parameters: {
//         tagName: {
//           value: item.key
//         }
//         tagValue: {
//           value: item.value
//         }
//       }
//     }
//   }
// ]

// module tagsOnResources 'br/public:avm/ptn/authorization/policy-assignment:0.1.0' = [
//   for item in items(resourceTags): {
//     name: 'tag-${item.key}'
//     params: {
//       name: 'tag-${item.key}'
//       displayName: 'tag: ${item.key}'
//       location: params.location
//       policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/4f9dc7db-30c1-420c-b61a-e1d640128d26'
//       userAssignedIdentityId: identity.outputs.resourceId
//       subscriptionId: subscriptionId
//       parameters: {
//         tagName: {
//           value: item.key
//         }
//         tagValue: {
//           value: item.value
//         }
//       }
//     }
//   }
// ]

module securityContacts 'modules/securityContacts.bicep' = {
  name: 'lz-security-contacts'
  scope: subscription(subscriptionId)
}

output clientId string = identity.outputs.clientId
