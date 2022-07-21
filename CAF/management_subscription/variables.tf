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
  default = "mngmnt"
}

variable "owner" {
  type = string
  default = "servicedeskflynth@stepco.nl"
}

variable "deployed_by" {
  type = string
  default = "Jorrit Stutterheim"
}

variable "vnet_cidr" {
  description = "Valid non overlapping VNET IP range"
  type        = string
  default = "10.224.2.0/24"
}

variable "bastion_subnet_cidr" {
  description = "Valid non overlapping VNET IP range"
  type        = string
  default     = "10.224.2.0/26"
}

variable "mngmnt_subnet_cidr" {
  description = "Valid non overlapping VNET IP range"
  type        = string
  default     = "10.224.2.64/27"
}

variable "username_mngmnt" {
  type        = string
  default     = "fl_mngmnt_adm"
}