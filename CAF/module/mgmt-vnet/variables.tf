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

variable "mgmt-vnet-name" {
  default = "vnet-mgmt-weeu-01"
  type = string
}

variable "mgmt_address_space" {
    type = string
}

variable "mgmt_subnet_range" {
    type = string
}