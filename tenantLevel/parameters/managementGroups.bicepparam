using '../bicep/managementGroups.bicep'

param topLevelManagementGroupName = readEnvironmentVariable('TOP_LEVEL_MANAGEMENTGROUP_NAME', '')
param environment = readEnvironmentVariable('managementGroupHierarchy', '')
param childManagementGroupNames = [
  'platform'
  'playground'
  'online'
]
