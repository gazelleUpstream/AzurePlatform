targetScope = 'managementGroup'

param environment string
param entraIdGroupOwners array

module entraIdGroupReaders 'modules/groups.bicep' = {
  name: 'entra-readers'
  params: {
    displayName: 'azurePlatform-readers-${environment}'
    owners: entraIdGroupOwners
  }
}
