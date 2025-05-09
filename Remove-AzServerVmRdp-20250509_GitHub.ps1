# Script: Remove-AzServerVmRdp-20250509_GitHub.ps1
# Description: Removes the resource group and all associated resources for the server VM.

$resourceGroup = "MyTestRG"

# Remove everything
Remove-AzResourceGroup -Name $resourceGroup -Force -AsJob
