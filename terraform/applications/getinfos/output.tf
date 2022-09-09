output "jenkins_secret" {
  value = data.kubernetes_secret.jenkins_secrets.binary_data
  sensitive = true
  depends_on = [data.kubernetes_secret.jenkins_secrets]
}

output "grafana_secret" {
  value = data.kubernetes_secret.grafana_secrets.binary_data
  sensitive = true
  depends_on = [data.kubernetes_secret.grafana_secrets]
}