param (
    [Parameter(Mandatory = $true)]
    [string]$managementGroup
)

$query = "resourcecontainers
    | where type =~ 'microsoft.management/managementgroups'
    | extend parentManagementGroup = properties.details.parent.name
    | where parentManagementGroup contains  '$managementGroup'
    | project name"
    
$mgmtGroups = Search-AzGraph -Query $query -ManagementGroup $managementGroup
$mgmtGroups.Count
    
foreach ($item in $mgmtGroups) {
    $name = [string]$item.name
    Remove-AzManagementGroup -GroupName $name
    Write-Output "----------------"
}

