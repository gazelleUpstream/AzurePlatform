extension microsoftGraph


resource group 'Microsoft.Graph/groups@v1.0' = {
  displayName: 'fromBicep'
  mailEnabled: false
  mailNickname: 'frombicep'
  securityEnabled: true
  uniqueName: 'fromBicep'
  owners: [
    '0d6eb039-8df3-4a3d-a4f4-05254113fb9a'
  ]
}

output groupObjectId string = group.id
