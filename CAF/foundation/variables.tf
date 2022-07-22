# Use variables to customize the deployment

variable "root_id" {
  type    = string
  default = "Kimmymore"
}

variable "root_name" {
  type    = string
  default = "Kimmymore"
}

variable "management_root_group_id" {
  type    = string
  default = "/providers/Microsoft.Management/managementGroups/05116178-6e4e-4ef6-a9aa-640b8460f63d"
}

variable "vnet-peerings" {
  type = list(string)
  default = []
}

variable "environment" {
  default = "prd"
  type = string
}

variable "workload_name" {
  default = "platform"
  type = string
}

variable "owner" {
  default = "Kim Willemse"
  type = string
}