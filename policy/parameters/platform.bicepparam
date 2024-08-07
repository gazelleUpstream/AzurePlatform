using '../bicep/main-assignments.bicep'

param identityResoruceId = readEnvironmentVariable('POLICY_RESOURCE_ID', '')
param location = readEnvironmentVariable('AZURE_DEFAULT_LOCATION', '')
param environment = readEnvironmentVariable('managementGroupHierarchy', '')
param topLevelManagementGroupName = readEnvironmentVariable('TOP_LEVEL_MANAGEMENTGROUP_NAME', '')

var topLevelMgId = '${'/providers/Microsoft.Management/managementGroups/'}${topLevelManagementGroupName}'

param policies = [
  json(replace(loadTextContent('assignments/allowedResourceTypes.json'), '{{topLevel}}', topLevelMgId))
  json(replace(loadTextContent('assignments/allowedLocations.json'), '{{topLevel}}', topLevelMgId))
]
