resource "azurerm_resource_group" rg {
  name     = var.rg_name
  location = var.rg_location
}

resource "azurerm_eventhub_namespace" "event_hub_namespace" {
  name                = var.evnt_hub_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  capacity            = 2

  tags = {
    environment = "Kubernetes"
  }
}

resource "azurerm_eventhub" "event_hub_topic" {
  name                = "KubernetesEventHub"
  namespace_name      = azurerm_eventhub_namespace.event_hub_namespace.name
  resource_group_name = azurerm_resource_group.rg.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub_consumer_group" "logstash_consumer_group" {
  name                = "logstash"
  namespace_name      = azurerm_eventhub_namespace.event_hub_namespace.name
  eventhub_name       = azurerm_eventhub.event_hub_topic.name
  resource_group_name = azurerm_resource_group.rg.name
}