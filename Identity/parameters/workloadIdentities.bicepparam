using '../bicep/workloadIdentities.bicep'

param workloadName = 'workloadIdentity'
param location = readEnvironmentVariable('AZURE_DEFAULT_LOCATION', '')
param environment = readEnvironmentVariable('managementGroupHierarchy', '')
param subscriptionId = readEnvironmentVariable('MANAGEMENT_SUBSCRIPTION_ID', '')

param identity = {
  policy: {
    federatedCredentials: {}
    RBAC: {
      scope: 'gazelle-${environment}'
      roleDefinitions: [
        '/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'
      ]
    }
  }
}
