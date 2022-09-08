resource "azurerm_resource_group" rg {
  name     = var.rg_name
  location = var.rg_location
}

resource "azurerm_eventhub_namespace" "eventHubNs" {
  name                = var.evnt_hub_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  capacity            = 1

  tags = {
    environment = "Kubernetes"
  }
}

resource "azurerm_eventhub" "kubernetesEventHub" {
  name                = "KubernetesEventHub"
  namespace_name      = azurerm_eventhub_namespace.eventHubNs.name
  resource_group_name = azurerm_resource_group.rg.name
  partition_count     = 2
  message_retention   = 1
}