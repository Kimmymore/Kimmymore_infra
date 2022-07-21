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
  default = "ipgr"
}

variable "owner" {
  type = string
  default = "servicedeskflynth@stepco.nl"
}

variable "deployed_by" {
  type = string
  default = "Jorrit Stutterheim"
}

variable "foundation_ip_range" {
    type = string
    default = "10.224.0.0/16"
}