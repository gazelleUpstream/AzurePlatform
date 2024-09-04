param (
    [Parameter(Mandatory = $true)]
    [string]$topLevelManagementGroupName,
    [Parameter(Mandatory = $true)]
    [string]$managementSubscscriptionId
)


$deploymants = Get-AzManagementGroupDeployment -ManagementGroupId $topLevelManagementGroupName
write-output "management group deployment: $($deploymants.Count)"
$deploymants | foreach-object -ThrottleLimit 25 -Parallel {
    Remove-AzManagementGroupDeployment -Id $_.Id -verbose
}


$deploymants = Get-AzSubscriptionDeployment -Id $managementSubscscriptionId
write-output "subscription deployment: $($deploymants.Count)"
$deploymants | foreach-object -ThrottleLimit 25 -Parallel {
    Remove-AzSubscriptionDeployment -id $_.id -verbose -WhatIf
}