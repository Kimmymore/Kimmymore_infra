data "azurerm_policy_definition" "tags_on_rg" {
  display_name = "Require a tag on resource groups"
}

data "azurerm_policy_definition" "inherit_from_rg" {
  display_name = "Inherit a tag from the resource group"
}

# resource "azurerm_subscription_policy_assignment" "require_tags_on_rg" {
#   for_each             = toset(var.tag_list)
#   name                 = "Require tag ${each.key} on resource groups"
#   policy_definition_id = data.azurerm_policy_definition.tags_on_rg.id
#   subscription_id      = var.subscription_id
#   enforce              = true

#   non_compliance_message {
#     content = "Required tag ${each.key} on RG"
#   }

#   parameters = <<PARAMETERS
#     {
#         "tagName": {
#           "type": "String",
#           "metadata": {
#             "displayName": "Mandatory Tag ${each.key}",
#             "description": "Name of the tag, such as ${each.key}"
#           },
#           "value": "${each.key}"
#         }
#     }
# PARAMETERS

#   lifecycle {
#     ignore_changes = [
#       parameters
#     ]
#   }
# }

resource "azurerm_subscription_policy_assignment" "inherit_tags_from_rg" {
  for_each             = toset(var.tag_list)
  name                 = "Inherit tag ${each.key} from the resource group"
  policy_definition_id = data.azurerm_policy_definition.inherit_from_rg.id
  subscription_id      = var.subscription_id
  enforce              = true
  location             = var.location

  identity {
    type = "SystemAssigned"
  }

  non_compliance_message {
    content = "Issue in tag ${each.key} inheritance policy"
  }

  parameters = <<PARAMETERS
    {
        "tagName": {
          "type": "String",
          "metadata": {
            "displayName": "Inherit mandatory Tag ${each.key}",
            "description": "Name of the tag, such as ${each.key}"
          },
          "value": "${each.key}"
        }
    }
PARAMETERS

  lifecycle {
    ignore_changes = [
      parameters
    ]
  }
}
