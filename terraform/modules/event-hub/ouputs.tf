output "event_hub_id" {
  value = azurerm_eventhub.event_hub_topic.id
}
output "event_hub_name" {
  value = azurerm_eventhub.event_hub_topic.name
}

output "event_hub_namespace_rg_name" {
  value = azurerm_eventhub_namespace.event_hub_namespace.resource_group_name
}

output "event_hub_namespace_name" {
  value = azurerm_eventhub_namespace.event_hub_namespace.name
}