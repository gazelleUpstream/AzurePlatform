targetScope = 'managementGroup'

param workloadName string
param environment string
param location string = deployment().location
param subscriptionId string
param roleDefinitions array

var policyIdentityResourceGroupName = '${workloadName}-identity-${environment}'

module IdentityResourceGroup 'modules/resourceGroup.bicep' = {
  scope: subscription(subscriptionId)
  name: 'rg-${workloadName}-identity'
  params: {
    location: location
    resourceGroupName: policyIdentityResourceGroupName
  }
}

module uami 'modules/userAssignedManagedIdentity.bicep' = {
  scope: resourceGroup(subscriptionId, policyIdentityResourceGroupName)
  dependsOn: [
    IdentityResourceGroup
  ]
  name: 'uami-${workloadName}'
  params: {
    environment: environment
    workloadName: workloadName
    location: location
  }
}

module rbac 'modules/roleAssignment.bicep' = {
  name: 'rbac-${workloadName}'
  params: {
    principlesId: uami.outputs.principalId
    roleDefinitions: roleDefinitions
  }
}

output gitHubEnviromentVariables object = {
  POLICY_IDENTITY_RESOURCE_ID: uami.outputs.resourceId
}
