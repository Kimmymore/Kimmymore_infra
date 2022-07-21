locals {
    year = formatdate("YYYY", timestamp())
    month = formatdate("MM", timestamp())
}

resource "azurerm_monitor_action_group" "budget_action_group" {
  name                = "BudgetAlertsActionGroup"
  resource_group_name = azurerm_resource_group.lz_resource_groups["rg-shared-${var.environment}-${var.postfix}"].name
  short_name          = "budgAction"

  email_receiver {
    name          = "sendToFlynth"
    email_address = "servicedeskflynth@stepco.nl"
  }
}

resource "azurerm_consumption_budget_subscription" "lz_consumption_budget" {
  name            = "consumption_budget"
  subscription_id = data.azurerm_subscription.current.id

  amount     = 1000
  time_grain = "Monthly"

  time_period {
    start_date = "${local.year}-${local.month}-01T00:00:00Z"
  }

  notification {
    enabled   = true
    threshold = 95.0
    operator  = "GreaterThanOrEqualTo"
    threshold_type = "Forecasted"

    contact_emails = concat([var.owner], var.budget_alert_recipients)
    contact_groups = [
      "${azurerm_resource_group.lz_resource_groups["rg-shared-${var.environment}-${var.postfix}"].id}/providers/microsoft.insights/actionGroups/${azurerm_monitor_action_group.budget_action_group.name}"
    ]
  }

  lifecycle {
    ignore_changes = [
      time_period
    ]
  }
}
