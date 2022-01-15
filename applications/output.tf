output "kube_config" {
  value = module.k8s-cluster.kube_config
  sensitive = true
}