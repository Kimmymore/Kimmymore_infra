# Will this landing zone contain VM workloads (recovery service vault deployed)
vm_workloads = true
# Contact person / requestor of the new landing zone
owner = "marc.zijlstra@flynth.nl"

# Budget alerts will be send to the following recipients, owner will be added automatically
budget_alert_recipients = ["servicedeskflynth@stepco.nl"]

# Name will be used in Azure resource naming, may not contain spaces
workload_name = "fds"
environment = "prd"

# Azure Vnet Sizing
# XS: /28 (available IPs: 6)
# S: /27 (available IPs: 22)
# M: /26 (available IPs: 54)
# L: /25 (available IPs: 118)
# XL: /24 (available IPs: 246)
# XXL: /23 (available IPs: 512)*
vnet_cidr = "10.224.1.0/24"

# Deploy a default key vault in the landing zone
key_vault = true
use_rbac_for_keyvault = true


# Create service connection in the following ADO project for deployments to this landing zone
# azure_devops_project_name = ""
