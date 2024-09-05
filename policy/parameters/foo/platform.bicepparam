using 'main.bicep'

param categoryGroup = 'allLogs'
param diagnosticSettingName = 'platform'
param laEffect = 'DeployIfNotExists'
param topLevelManagementGroupName = readEnvironmentVariable('TOP_LEVEL_MANAGEMENTGROUP_NAME','')
param logAnalytics = readEnvironmentVariable('LOGANALYTICS_RESOURCE_ID','')
param identityResoruceId = readEnvironmentVariable('POLICY_IDENTITY_RESOURCE_ID','')
