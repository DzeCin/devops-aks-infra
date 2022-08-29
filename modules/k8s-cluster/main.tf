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

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = var.k8s_cluster_default_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.k8s_cluster_tags
}


resource "azurerm_kubernetes_cluster_node_pool" "node_pool" {
  for_each = { for pools in var.node_pools: pools.name => pools}
  name                  = each.value.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s_cluster.id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  depends_on = [azurerm_kubernetes_cluster.k8s_cluster]
}