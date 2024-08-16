param (
    [Parameter(Mandatory = $true)]
    [string]$managementGroup
)

$scope = "/providers/Microsoft.Management/managementGroups/$managementGroup"
$rbacAssignments = Get-AzRoleAssignment -scope $scope `
| Where-Object { $_.scope -eq $scope `
        -and $_.RoleDefinitionName -ne 'User Access Administrator' }

foreach ($item in $rbacAssignments) {
    $params = @{
        ObjectId           = $item.ObjectId
        RoleDefinitionName = $item.RoleDefinitionName
        scope              = $item.scope
    }
    Remove-AzRoleAssignment @params
    Write-Output "----------------"
}