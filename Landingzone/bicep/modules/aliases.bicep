targetScope = 'managementGroup'

@secure()
param billingScope string
param subscriptionName string

resource createSubscription 'Microsoft.Subscription/aliases@2021-10-01' = {
  scope: tenant()
  name: subscriptionName
  properties: {
    displayName: subscriptionName
    workload: 'Production'
    billingScope: billingScope
  }
}

output resourceName string = createSubscription.name
output resourceId string = createSubscription.id
