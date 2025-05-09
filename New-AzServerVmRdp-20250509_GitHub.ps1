# Script: New-AzServerVmRdp-20250509_GitHub.ps1
# Description: Deploys a Windows Server VM in Azure with RDP enabled and static public IP.

$resourceGroup = "MyTestRG"
$location = "westus"

# Create resource group
New-AzResourceGroup -Name $resourceGroup -Location $location

# Create VNet and Subnet
$subnetConfig = New-AzVirtualNetworkSubnetConfig -Name "MySubnet" -AddressPrefix "10.0.1.0/24"
$vnet = New-AzVirtualNetwork -Name "MyVNet" -ResourceGroupName $resourceGroup -Location $location `
         -AddressPrefix "10.0.0.0/16" -Subnet $subnetConfig

# Create NSG with RDP rule
$rdpRule = New-AzNetworkSecurityRuleConfig -Name "Allow-RDP" -Protocol "Tcp" -Direction "Inbound" `
            -Priority 1000 -SourceAddressPrefix "*" -SourcePortRange "*" `
            -DestinationAddressPrefix "*" -DestinationPortRange 3389 -Access "Allow"
$nsg = New-AzNetworkSecurityGroup -Name "MyNSG" -ResourceGroupName $resourceGroup -Location $location `
        -SecurityRules $rdpRule

# Create Public IP
$publicIp = New-AzPublicIpAddress -Name "MyPublicIP" -ResourceGroupName $resourceGroup -Location $location `
             -AllocationMethod Static -Sku Basic

# Create NIC
$subnet = Get-AzVirtualNetworkSubnetConfig -Name "MySubnet" -VirtualNetwork $vnet
$nic = New-AzNetworkInterface -Name "MyNIC" -ResourceGroupName $resourceGroup -Location $location `
         -SubnetId $subnet.Id -NetworkSecurityGroupId $nsg.Id -PublicIpAddress $publicIp

# Prompt for credentials
$cred = Get-Credential -Message "Enter admin credentials for the Server VM"

# Configure and deploy VM
$vmConfig = New-AzVMConfig -VMName "MyServerVM" -VMSize "Standard_B1s"
$vmConfig = Set-AzVMOperatingSystem -VM $vmConfig -Windows -ComputerName "MyServerVM" -Credential $cred
$vmConfig = Set-AzVMSourceImage -VM $vmConfig -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" `
             -Skus "2019-Datacenter" -Version "latest"
$vmConfig = Add-AzVMNetworkInterface -VM $vmConfig -Id $nic.Id

New-AzVM -ResourceGroupName $resourceGroup -Location $location -VM $vmConfig
