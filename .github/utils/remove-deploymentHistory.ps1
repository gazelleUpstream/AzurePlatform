param (
    [Parameter(Mandatory = $true)]
    [string]$topLevelManagementGroupName,
    [Parameter(Mandatory = $true)]
    [string]$managementSubscscriptionId
)


$MgDeployment = Get-AzManagementGroupDeployment -ManagementGroupId $topLevelManagementGroupName
write-output "management group deployment: $($MgDeployment.Count)"
$MgDeployment | foreach-object -ThrottleLimit 25 -Parallel {
    Remove-AzManagementGroupDeployment -Id $_.Id -verbose
}

Select-AzSubscription $managementSubscscriptionId

$SubscriptionDeployment = Get-AzSubscriptionDeployment -Id $managementSubscscriptionId
write-output "subscription deployment: $($SubscriptionDeployment.Count)"
$SubscriptionDeployment | foreach-object -ThrottleLimit 50 -Parallel {
    Remove-AzSubscriptionDeployment -Id $_.id -verbose
}