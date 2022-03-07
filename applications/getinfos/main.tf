terraform {
  required_providers {
   kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.8.0"
    }
  }
}

provider "kubernetes" {
  config_path    = "../../kubeconfig"
}

data "kubernetes_secret" "jenkins-secrets" {
  metadata {
    name      = "jenkins"
    namespace = "jenkins"
  }
  binary_data = {
    "jenkins-admin-password" = ""
    "jenkins-admin-user"  = ""
  }
}

data "kubernetes_secret" "grafana-secrets" {
  metadata {
    name      = "prometheus-community-grafana"
    namespace = "monitoring"
  }
  binary_data = {
    "admin-password" = ""
    "admin-user"  = ""
  }
}




