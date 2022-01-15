resource "azurerm_kubernetes_cluster_node_pool" "node-pool" {
  for_each = { for pools in var.node-pools: pools.name => pools}
  name                  = each.value.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s-cluster.id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  depends_on = [azurerm_kubernetes_cluster.k8s-cluster]
}