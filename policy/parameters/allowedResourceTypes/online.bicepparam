using 'main.bicep'

param identityResoruceId = readEnvironmentVariable('POLICY_RESOURCE_ID', '')
param topLevelManagementGroupName = readEnvironmentVariable('TOP_LEVEL_MANAGEMENTGROUP_NAME','')

