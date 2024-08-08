extension microsoftGraph

targetScope = 'managementGroup'

param displayName string 
param owners array


resource group 'Microsoft.Graph/groups@v1.0' = {
  displayName: displayName
  mailEnabled: false
  mailNickname: displayName
  securityEnabled: true
  uniqueName: displayName
  owners:  owners
}

output groupObjectId string = group.id
