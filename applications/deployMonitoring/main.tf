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



module "eventHub" {
  source = "../../modules/event-hub"
  rg_location = "West Europe"
  rg_name = "Monitoring"
  evnt_hub_name = "KubernetesEventHubNamespace"
}