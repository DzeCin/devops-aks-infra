output "log_analytics_workspace_id" {
  value = module.log_analytics.log_analytics_workspace_id
}

output "event_hub_name" {
  value = module.event_hub.event_hub_name
}

output "event_hub_namespace_rg_name" {
  value = module.event_hub.event_hub_namespace_rg_name
}

output "event_hub_namespace_name" {
  value = module.event_hub.event_hub_namespace_name
}