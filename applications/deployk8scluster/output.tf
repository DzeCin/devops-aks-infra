output "kube_config" {
  value = module.k8s-cluster.kube_config
  sensitive = true
}

output "acr_url" {
  value = module.acr.url
  sensitive = true
}

output "acr_admin_username" {
  value = module.acr.admin_username
  sensitive = true
}

output "acr_admin_password" {
  value = module.acr.admin_password
  sensitive = true
}