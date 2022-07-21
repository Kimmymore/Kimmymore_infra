variable "workload-name" {
  default = "bastion"
  type    = string
}

variable "regioncode" {
  default = "weu"
  type    = string
}

variable "instancenumber" {
  default = "1"
  type    = string
}

variable "location" {
  default = "westeurope"
  type    = string
}

variable "bastion_vnet-name" {
  default = "vnet-mgmt-weeu-001"
  type    = string
}

variable "bastion_vnet-rg-name" {
  default = "rg-mgmt-weeu-001"
  type    = string
}

variable "bastion_subnet-range" {
  type = string
}
