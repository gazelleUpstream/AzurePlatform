using '../bicep/foo.bicep'

param categoryGroup = 'allLogs'
param diagnosticSettingName = 'withLoveFromBicep'
param laEffect = 'DeployIfNotExists'
param favPolicyValue = 'Audit'
// param anotherPolicyValue = 'Modify'
param logAnalytics = readEnvironmentVariable('','')
param identityResoruceId = readEnvironmentVariable('POLICY_RESOURCE_ID','')
param location = readEnvironmentVariable('AZURE_DEFAULT_LOCATION', '')
