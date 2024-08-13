using 'main.bicep'

param categoryGroup = 'allLogs'
param diagnosticSettingName = 'platform'
param laEffect = 'DeployIfNotExists'
param favPolicyValue = 'Deny'
param logAnalytics = readEnvironmentVariable('LOGANALYTICS_RESOURCE_ID','')
param identityResoruceId = readEnvironmentVariable('POLICY_RESOURCE_ID','')
param location = readEnvironmentVariable('AZURE_DEFAULT_LOCATION', '')
