output "kube_config" {
  value = azurerm_kubernetes_cluster.k8s-cluster.kube_config_raw

  sensitive = true
}

output "kubelet_id" {
  value = azurerm_kubernetes_cluster.k8s-cluster.kubelet_identity[0].object_id
}