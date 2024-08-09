targetScope = 'managementGroup'


param billingAccountName string
param billingProfileName string
param invoiceSections array

module invoice 'modules/invoice.bicep' = [
  for item in invoiceSections: {
    name: 'invoiceSection-${item}'
    params: {
      billingAccountName: billingAccountName
      billingProfileName: billingProfileName
      invoiceSectionName: item
    }
  }
]

output gitHubEnviromentVariables array = [
  for (item, i) in invoiceSections: {
    '${item}_billingScope' : invoice[i].outputs.invoiceSectionResourceId
  }
]
