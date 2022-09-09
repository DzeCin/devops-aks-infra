terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.21.1"
    }
  }
}


provider "azurerm" {
  features {}
}


module "event_hub" {
  source = "../../modules/event-hub"
  rg_location = "West Europe"
  rg_name = "Monitoring"
  evnt_hub_name = "KubernetesEventHubNamespace"
}

module "log_analytics" {
  source = "../../modules/log-analytics"
  rg_location = "West Europe"
  rg_name = "LogAnalytics"
  event_hub_id = module.event_hub.event_hub_id
  depends_on = [module.event_hub]
}