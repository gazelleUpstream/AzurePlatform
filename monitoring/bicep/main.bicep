targetScope = 'subscription'

param workloadName string = 'monitoring'
param environment string
param location string = deployment().location

var name = 'la-${workloadName}-${environment}'

resource monitoringResourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: '${workloadName}-${environment}'
  location: location
}

module la 'br/public:avm/res/operational-insights/workspace:0.4.0' = {
  scope: monitoringResourceGroup
  name: 'la-deployment'
  params: {
    name: name
  }
}

output gitHubEnviromentVariables object = {
  logAnalytics_Resource_Id: la.outputs.resourceId
  logAnalytics_Workspace_Id: la.outputs.logAnalyticsWorkspaceId
}
