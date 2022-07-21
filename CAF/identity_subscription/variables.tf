variable "location" {
  default = "westeurope"
  type    = string
}

variable "postfix" {
  default = "weu-001"
  type    = string
}

variable "env" {
  default = "prd"
  type    = string
}

variable "workload_name" {
  type = string
  default = "identity"
}

variable "owner" {
  type = string
  default = "Kim Willemse"
}

variable "deployed_by" {
  type = string
  default = "Kim Willemse"
}

variable "vnet_cidr" {
  description = "Valid non overlapping VNET IP range"
  type        = string
  default = "10.224.3.0/27"
}

variable "domain_controller_subnet_cidr" {
  description = "Valid non overlapping VNET IP range"
  type        = string
  default     = "10.224.3.0/27"
}

variable "username_dc1" {
  type = string
  default = "fl_dc_one_adm"
}

variable "username_dc2" {
  type = string
  default = "fl_dc_two_adm"
}