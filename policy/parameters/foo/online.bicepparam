using 'main.bicep'

param categoryGroup = 'allLogs'
param diagnosticSettingName = 'withLoveFromBicep'
param laEffect = 'DeployIfNotExists'
param topLevelManagementGroupName = readEnvironmentVariable('TOP_LEVEL_MANAGEMENTGROUP_NAME','')
param logAnalytics = readEnvironmentVariable('LOGANALYTICS_RESOURCE_ID','')
param identityResoruceId = readEnvironmentVariable('POLICY_RESOURCE_ID','')
param location = readEnvironmentVariable('AZURE_DEFAULT_LOCATION', '')
