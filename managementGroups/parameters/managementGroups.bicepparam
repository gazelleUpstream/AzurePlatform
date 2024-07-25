using '../bicep/main-managementGroups.bicep'

param topLevelManagementGroupName = readEnvironmentVariable('TOP_LEVEL_MANAGEMENTGROUP_NAME', '')
param environment = readEnvironmentVariable('environment', '')
param managementSubscriptionId = readEnvironmentVariable('MANAGEMENT_SUBSCRIPTION_ID', '')
param childManagementGroupNames = [
  'platform'
  'playground'
  'online'
]
