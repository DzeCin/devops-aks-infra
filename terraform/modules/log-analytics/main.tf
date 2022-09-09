resource "azurerm_resource_group" rg {
  name     = var.rg_name
  location = var.rg_location
}


resource "random_id" "workspace" {
  keepers = {
    # Generate a new id each time we switch to a new resource group
    group_name = azurerm_resource_group.rg.name
  }

  byte_length = 8
}

resource "azurerm_log_analytics_workspace" "k8s_log_analytics_workspace" {
  name                = "k8s-workspace-${random_id.workspace.hex}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
}

resource "azurerm_log_analytics_solution" "container_insights_k8s" {
  solution_name         = "ContainerInsights"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  workspace_resource_id = azurerm_log_analytics_workspace.k8s_log_analytics_workspace.id
  workspace_name        = azurerm_log_analytics_workspace.k8s_log_analytics_workspace.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

resource "azurerm_log_analytics_data_export_rule" "export_to_event_hub" {
  name                    = "toEventHub"
  resource_group_name     = azurerm_resource_group.rg.name
  workspace_resource_id   = azurerm_log_analytics_workspace.k8s_log_analytics_workspace.id
  destination_resource_id = var.event_hub_id
  table_names             = ["KubeHealth", "KubeNodeInventory", "KubePodInventory"]
  enabled                 = true
}


