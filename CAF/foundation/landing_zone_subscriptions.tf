data "azurerm_management_group" "Kimmymore" {
  name = "mgmtgroup-Kimmymore"
}

data "azurerm_subscription" "Kimmymore" {
    provider = azurerm.Kimmymore
}

resource "azurerm_management_group_subscription_association" "lz_Kimmymore_assoc" {
  management_group_id = data.azurerm_management_group.Kimmymore.id
  subscription_id     = data.azurerm_subscription.Kimmymore.id
}
