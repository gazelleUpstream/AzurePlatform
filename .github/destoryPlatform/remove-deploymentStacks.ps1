param (
    [Parameter(Mandatory = $true)]
    [string]$managementSubscscriptionId,
    [Parameter(Mandatory = $true)]
    [string]$topLevelManagementGroupName
)


Select-AzSubscription -subscriptionId $managementSubscscriptionId

$subscriptionStacks =  Get-AzSubscriptionDeploymentStack 
Write-Output "deployment stacks to be deleted:"
$subscriptionStacks.name
$subscriptionStacks | foreach-object -ThrottleLimit 5 -Parallel {
    Remove-AzSubscriptionDeploymentStack -ResourceId $_.id -ActionOnUnmanage DeleteAll -Force -Verbose
}


$managementGroupStacks = Get-AzManagementGroupDeploymentStack -ManagementGroupId $topLevelManagementGroupName
Write-Output "deployment stacks to be deleted:"
$managementGroupStacks.name
$managementGroupStacks | foreach-object -ThrottleLimit 5 -Parallel {
    Remove-AzManagementGroupDeploymentStack -ResourceId $_.id -ActionOnUnmanage DeleteAll -Force -Verbose
}