resource "azuredevops_project" "project" {
  name        = var.project_name
  description = var.project_description
  visibility  = "private"
  features = {
    "boards"       = "enabled"
    "repositories" = "enabled"
    "pipelines"    = "enabled"
    "testplans"    = "enabled"
    "artifacts"    = "enabled"
  }
}

resource "azuredevops_git_repository" "repo" {
  project_id     = azuredevops_project.project.id
  name           = "main"
  default_branch = "refs/heads/main"
  initialization {
    init_type = "Clean"
  }
  lifecycle {
    ignore_changes = [
      # Ignore changes to initialization to support importing existing repositories
      # Given that a repo now exists, either imported into terraform state or created by terraform,
      # we don't care for the configuration of initialization against the existing resource
      initialization,
    ]
  }
}

resource "azuredevops_git_repository_file" "gitignore" {
  repository_id       = azuredevops_git_repository.repo.id
  file                = ".gitignore"
  content             = var.gitignore_value
  branch              = "refs/heads/main"
  commit_message      = "add gitignore"
  overwrite_on_create = false

  lifecycle {
    ignore_changes = all
  }
}

resource "azuredevops_serviceendpoint_azurerm" "service_connection" {
  project_id            = azuredevops_project.project.id
  service_endpoint_name = "SC-${data.azurerm_subscription.current.display_name}"
  description           = "Service connection for ${data.azurerm_subscription.current.display_name}"
  credentials {
    serviceprincipalid  =  azuread_service_principal.spn.object_id
    serviceprincipalkey =  azuread_application_password.spn_secret.value
  }
  azurerm_spn_tenantid      = data.azurerm_subscription.current.tenant_id
  azurerm_subscription_id   = data.azurerm_subscription.current.subscription_id
  azurerm_subscription_name = data.azurerm_subscription.current.display_name
}
