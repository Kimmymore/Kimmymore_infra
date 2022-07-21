module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.1.1"
  suffix  = [var.prefix, var.environment]
}

locals {
  naming_prefix           = "${var.prefix}-${var.environment}-${var.postfix}"
  naming_prefix_no_hyphen = join("", [var.prefix, var.environment, var.postfix])
}
