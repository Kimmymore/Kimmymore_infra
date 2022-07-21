data "azurerm_management_group" "fds" {
  name = "flynth-fds"
}

data "azurerm_subscription" "fds" {
    provider = azurerm.fds
}

resource "azurerm_management_group_subscription_association" "lz_fds_assoc" {
  management_group_id = data.azurerm_management_group.fds.id
  subscription_id     = data.azurerm_subscription.fds.id
}
