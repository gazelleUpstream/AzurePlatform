using '../bicep/main-definitions.bicep'

param customDefinitions = [
  loadJsonContent('customDefinitions/st_corssTenantReplication.json')
  loadJsonContent('customDefinitions/st_vnetAclrRules.json')
]
