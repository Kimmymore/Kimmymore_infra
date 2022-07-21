locals {
  default_location = "westeurope"
  default_tags     = {
  }

  custom_landing_zones = {
    "${var.root_id}-online" = {
      display_name               = "Online"
      parent_management_group_id = "${var.root_id}-landing-zones"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "online"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-digitaldatacenter" = {
      display_name               = "DigitalDataCenter"
      parent_management_group_id = "${var.root_id}-landing-zones"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "digitaldatacenter"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-azurevd" = {
      display_name               = "AzureVD"
      parent_management_group_id = "${var.root_id}-landing-zones"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "azurevd"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-office" = {
      display_name               = "Office"
      parent_management_group_id = "${var.root_id}-landing-zones"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "office"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-dms" = {
      display_name               = "DMS"
      parent_management_group_id = "${var.root_id}-landing-zones"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "dms"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-fds" = {
      display_name               = "FDS"
      parent_management_group_id = "${var.root_id}-landing-zones"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "fds"
        parameters     = {}
        access_control = {}
      }
    }
  }

  configure_management_resources = {
    settings = {
      log_analytics = {
        enabled = true
        config = {
          retention_in_days                                 = 30
          enable_monitoring_for_arc                         = false
          enable_monitoring_for_vm                          = true
          enable_monitoring_for_vmss                        = true
          enable_solution_for_agent_health_assessment       = true
          enable_solution_for_anti_malware                  = true
          enable_solution_for_azure_activity                = true
          enable_solution_for_change_tracking               = false
          enable_solution_for_service_map                   = true
          enable_solution_for_sql_assessment                = true
          enable_solution_for_updates                       = true
          enable_solution_for_vm_insights                   = true
          enable_sentinel                                   = false
          enable_solution_for_sql_advanced_threat_detection = true
          enable_solution_for_sql_vulnerability_assessment  = true

        }
      }
      security_center = {
        enabled = true
        config = {
          email_security_contact             = "servicedeskflynth@stepco.nl"
          enable_defender_for_acr            = true
          enable_defender_for_app_services   = true
          enable_defender_for_arm            = true
          enable_defender_for_dns            = true
          enable_defender_for_key_vault      = true
          enable_defender_for_kubernetes     = true
          enable_defender_for_oss_databases  = true
          enable_defender_for_servers        = true
          enable_defender_for_sql_servers    = true
          enable_defender_for_sql_server_vms = true
          enable_defender_for_storage        = true
          enable_defender_for_containers     = true
        }
      }
    }
    advanced = {
      custom_settings_by_resource_type = {
        azurerm_resource_group = {
          management = {
            name = "rg-platform-management-prd-weu-001"
          }
        },
        azurerm_log_analytics_workspace = {
          management = {
            name = "log-platform-prd-weu-001"
          }
        },
        azurerm_automation_account = {
          management = {
            name = "aut-management-prd-weu-001"
          }
        }
      }
    }

    tags = {}

    location = "westeurope"
  }
}
