$buildIdRoles = Get-AzRoleDefinition | Where-Object { $_.IsCustom -like 'False' }
$rbacMapping = @{}
foreach ($item in $buildIdRoles) {
    $rbacMapping[($item.Name -replace ' ', '')] = "/providers/Microsoft.Authorization/roleDefinitions/$($item.Id)"
}

$json = $rbacMapping | ConvertTo-Json 

$output = $json | Out-File 'AzureRoleDefinitions.json'
