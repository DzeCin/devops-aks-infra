output "jenkins-secret" {
  value = data.kubernetes_secret.jenkins-secrets.binary_data
  sensitive = true
  depends_on = [data.kubernetes_secret.jenkins-secrets]
}

output "grafana-secret" {
  value = data.kubernetes_secret.grafana-secrets.binary_data
  sensitive = true
  depends_on = [data.kubernetes_secret.grafana-secrets]
}