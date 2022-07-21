variable "rg-name" {
  default = "rg-platform-dns-vnet"
  type = string
}

variable "vnet-name" {
  default = "vnet-platform-dns"
  type = string
}

variable "location" {
    default = "westeurope"
    type = string
}

variable "address_space" {
    default = "10.12.2.0/24"
    type = string
}

variable "dns_subnet_range" {
    default = "10.12.2.0/27"
    type = string
}

variable "private_dns_zones" {
  type = map(any)
}

variable "rg_dns_zones" {
  default = "rg-platform-connectivity-dns"
}

variable "rg_storageaccount_name" {
}

variable "username_dns_servers" {
  default = "machineadmin"
}

variable "password_dns_servers" {
  sensitive = true
}
