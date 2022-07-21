# resource "azurerm_storage_account" "st_terraform" {
#   name                      = "sttf${var.environment}weu001"
#   resource_group_name       = azurerm_resource_group.lz_resource_groups["rg-shared-${var.environment}-${var.postfix}"].name
#   location                  = azurerm_resource_group.lz_resource_groups["rg-shared-${var.environment}-${var.postfix}"].location
#   account_tier              = "Standard"
#   account_replication_type  = "GRS"
#   shared_access_key_enabled = true

#   #   network_rules {
#   #     default_action             = "Deny"
#   #     ip_rules                   = []
#   #     virtual_network_subnet_ids = [azurerm_subnet.default_node_pool_snet.id]
#   #   }

#   lifecycle {
#     ignore_changes = [
#       tags,
#     ]
#   }
# }

# resource "azurerm_storage_container" "tf_container" {
#   name                  = "tfstate"
#   storage_account_name  = azurerm_storage_account.st_terraform.name
#   container_access_type = "private"
# }

# # resource "azurerm_role_assignment" "spn_to_storage" {
# #   count                            = var.state_storage_account ? 1 : 0
# #   scope                            = azurerm_storage_account.st_terraform.0.id
# #   role_definition_name             = "Storage Account Contributor"
# #   principal_id                     = azuread_service_principal.spn.object_id
# #   skip_service_principal_aad_check = false
# # }
