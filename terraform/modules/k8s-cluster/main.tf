resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.rg_location
}


resource "azurerm_kubernetes_cluster" "k8s_cluster" {
  name                = var.k8s_cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.k8s_cluster_name
  kubernetes_version = var.k8s_version

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = var.k8s_cluster_default_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.k8s_cluster_tags

  depends_on=[azurerm_resource_group.rg]
}

resource "azurerm_kubernetes_cluster_node_pool" "node_pool" {
  for_each = { for pools in var.node_pools: pools.name => pools}
  name                  = each.value.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s_cluster.id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  depends_on = [azurerm_kubernetes_cluster.k8s_cluster]
}

data "azurerm_eventhub_namespace_authorization_rule" "event_hub_namespace_authorization_rule" {
  name                = "RootManageSharedAccessKey"
  resource_group_name = var.event_hub_namespace_rg_name
  namespace_name      = var.event_hub_namespace_name
}



resource "azurerm_monitor_diagnostic_setting" "azure_diagnostics" {
  name               = "K8sDiagnostics"
  eventhub_authorization_rule_id = data.azurerm_eventhub_namespace_authorization_rule.event_hub_namespace_authorization_rule.id
  eventhub_name = var.event_hub_name
  target_resource_id = azurerm_kubernetes_cluster.k8s_cluster.id

  log {
    category = "kube-audit-admin"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }
}