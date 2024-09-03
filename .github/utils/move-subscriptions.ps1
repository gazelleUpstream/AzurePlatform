param (
    [Parameter(Mandatory = $true)]
    [string]$managementGroup
)

$query = "resourcecontainers
      | where type == 'microsoft.resources/subscriptions'
      | project subscriptionId"

$subscriptions = Search-AzGraph -Query $query -ManagementGroup $managementGroup
$subscriptions.Count
    
foreach ($item in $subscriptions) {
    $id = [string]$item.subscriptionId
    New-AzManagementGroupSubscription -GroupName $managementGroup -SubscriptionId $id
}

