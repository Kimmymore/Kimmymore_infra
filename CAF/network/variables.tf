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

variable "vwan_cidr" {
  default = "10.224.0.0/16"
  type    = string
}
