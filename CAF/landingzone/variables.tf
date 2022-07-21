variable "location" {
  default = "westeurope"
  type    = string
}

variable "DeployedBy" {
  default = "jorrit.stutterheim@cloudnation.nl"
  type    = string
}

variable "postfix" {
  default = "weu-001"
  type    = string
}

variable "environment" {
  type = string
}

variable "workload_name" {
  type = string
}

variable "owner" {
  type = string
}

variable "prefix" {
  description = "A prefix used for all resources in this example"
  type        = string
  default     = "shared"
}

variable "budget_alert_recipients" {
  description = "List containing emailadresses of cost alert recipients"
  default = []
  type = list
}

# variable "state_storage_account" {
#   description = "A flag whether to create a shared storage account for storing terraform state"
#   type        = bool
# }

variable "key_vault" {
  description = "A flag whether to create a shared key vault in this landing zone"
  type        = bool
}

variable "vm_workloads" {
  description = "A flag whether to create a service recovery vault (if VM workloads will be used)"
  type        = bool
}

variable "vnet_cidr" {
  description = "Valid non overlapping VNET IP range"
  type        = string
}

variable "use_rbac_for_keyvault" {
  description = "Indicate whether RBAC or access policies will be used."
  type        = bool
}

