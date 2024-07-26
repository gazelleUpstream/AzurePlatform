using '../bicep/main-assignments.bicep'

param identityResoruceId = readEnvironmentVariable('POLICY_RESOURCE_ID', '')
param location = readEnvironmentVariable('AZURE_DEFAULT_LOCATION', '')
param environment = readEnvironmentVariable('environment', '')
param topLevelManagementGroupName = readEnvironmentVariable('TOP_LEVEL_MANAGEMENTGROUP_NAME', '')

var topLevelMgId = '${'/providers/Microsoft.Management/managementGroups/'}${topLevelManagementGroupName}'

param policies = [
  json(replace(loadTextContent('assignments/test.json'), '{{topLevel}}', topLevelMgId))
]
