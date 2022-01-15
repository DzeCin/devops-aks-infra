output "kube_config" {
  value = azurerm_kubernetes_cluster.k8s-cluster.kube_config_raw

  sensitive = true
}