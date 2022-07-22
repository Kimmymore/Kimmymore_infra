data "azurerm_client_config" "core" {
  provider = azurerm
}

# Obtain client configuration from the "management" provider
data "azurerm_client_config" "management" {
  provider = azurerm.management
}

# Obtain client configuration from the "connectivity" provider
data "azurerm_client_config" "connectivity" {
  provider = azurerm.connectivity
}

data "azurerm_client_config" "identity" {
  provider = azurerm.identity
}

module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "2.1.0"

  # Map each module provider to their corresponding `azurerm` provider using the providers input object, this enables multi subscription deployments

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm.connectivity
    azurerm.management   = azurerm.management
  }

  # Base module configuration settings
  root_parent_id    = data.azurerm_client_config.core.tenant_id
  root_id           = var.root_id
  root_name         = var.root_name
  library_path      = "${path.root}/lib"
  default_tags      = local.default_tags
  disable_telemetry = true

  # Configuration settings for identity resources
  deploy_identity_resources     = false
  subscription_id_identity      = data.azurerm_client_config.identity.subscription_id
  configure_identity_resources  = local.configure_identity_resources

  # Configuration settings for connectivity resources
  deploy_connectivity_resources = true # connectivity resources are deployed using our custom Connectivity
  configure_connectivity_resources = local.configure_connectivity_resources
  subscription_id_connectivity =  data.azurerm_client_config.connectivity.subscription_id


  # Configuration settings for management resources
  deploy_management_resources    = false
  configure_management_resources = local.configure_management_resources
  subscription_id_management     = data.azurerm_client_config.management.subscription_id

  deploy_core_landing_zones = false
  deploy_online_landing_zones = false
  custom_landing_zones = local.custom_landing_zones
}
