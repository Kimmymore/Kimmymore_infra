variable "location" {
    type = string
}

variable "tag_list" {
  description = "List containing tags which are mandatory on resource groups"
  type = list
}

variable "subscription_id" {
  type = string
}