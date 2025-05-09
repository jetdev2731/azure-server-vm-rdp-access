# Deploy and Clean Up Azure Windows Server VM via PowerShell

Automate the full lifecycle of a Windows Server virtual machine in Azure — from deployment to secure RDP access and safe cleanup — using PowerShell.

---

## 🛠 What This Script Does (`New-AzServerVmRdp-20250509_GitHub.ps1`)

- Creates a resource group (`MyTestRG`)
- Builds a VNet, Subnet, and NSG (with RDP rule)
- Creates a NIC and Public IP
- Deploys a Windows Server 2022 VM with RDP enabled
- Prompts you for admin credentials
- Outputs the assigned public IP for RDP access

---

## 🚀 How to Use

1. Open PowerShell and authenticate:

```powershell
Connect-AzAccount
Set-AzContext -SubscriptionId "<your-subscription-id>"
```

2. Save and run the script:

```powershell
.\New-AzServerVmRdp-20250509_GitHub.ps1
```

3. Use the public IP and your credentials to RDP into the VM.

---

## 🧹 How to Clean Up (`Remove-AzServerVmRdp-20250509_GitHub.ps1`)

To avoid charges for unused resources (disk, IP, NIC, etc.), delete the resource group after testing:

```powershell
Remove-AzResourceGroup -Name "MyTestRG" -Force -AsJob
```

This removes:
- The VM (`MyServerVM`)
- Public IP (`MyPublicIP`)
- NIC (`MyNIC`)
- NSG (`MyNSG`)
- VNet + Subnet (`MyVNet`, `MySubnet`)
- Managed Disk
- And anything else in `"MyTestRG"`

---

## 📎 [View on GitHub](https://github.com/jetdev2731/azure-vm-rdp-access)

_Last updated: May 9, 2025_

