# data "azuread_user" "owner" {
#   user_principal_name = var.owner
# }

# resource "azuread_application" "spn_deployment" {
#    display_name     = "spn-deployment-${var.workload_name}"
#    owners = [data.azuread_user.owner.object_id]
# }

# resource "time_rotating" "example" {
#   rotation_days = 90
# }

# resource "azuread_application_password" "spn_secret" {
#   application_object_id = azuread_application.spn_deployment.id
#   display_name = "azdo_secret"
#   rotate_when_changed = {
#     rotation = time_rotating.example.id
#   }
# }

# resource "azuread_service_principal" "spn" {
#   application_id = azuread_application.spn_deployment.application_id
# }

# resource "azurerm_role_assignment" "contributer" {
#   role_definition_name = "Contributor"
#   principal_id = azuread_service_principal.spn.object_id
#   scope = data.azurerm_subscription.current.id
# }
