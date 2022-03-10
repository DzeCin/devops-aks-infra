terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "2.4.1"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.8.0"
    }

  }
}

provider "helm" {
  kubernetes {
    config_path = "../../kubeconfig"
  }
}

provider "kubernetes" {
  config_path    = "../../kubeconfig"
}


resource "helm_release" "nginx_ingress" {
  name       = "ingress-nginx"

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace = "kube-system"

}

## Uncomment to install monitoring stack
//resource "helm_release" "monitoring-stack" {
//  name       = "prometheus-community"
//
//  repository = "https://prometheus-community.github.io/helm-charts"
//  chart      = "kube-prometheus-stack"
//  namespace = "monitoring"
//  values = [file("grafanavalues.yml")]
//  create_namespace = true
//
//}


resource "helm_release" "jenkins" {
  name       = "jenkins"

  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  namespace = "jenkins"
  create_namespace = true
  values = [file("jenkinsvalues.yml")]
  depends_on = [helm_release.nginx_ingress]
}

resource "kubernetes_service_account" "deployment" {
  metadata {
    namespace = helm_release.jenkins.namespace
    name = "deployment"
  }
  depends_on = [helm_release.jenkins]
}

resource "kubernetes_cluster_role" "deployment" {
  metadata {
    name = "deployment"
  }
  rule {
    api_groups = ["*"]
    resources = ["*"]
    verbs = ["get","list","create", "patch"]
  }
  depends_on = [kubernetes_service_account.deployment]
}

resource "kubernetes_cluster_role_binding" "deployment_binding" {
  metadata {
    name = "deployment_binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind = "ClusterRole"
    name = "deployment"
  }
  subject {
    kind = "ServiceAccount"
    name = "deployment"
    namespace = helm_release.jenkins.namespace
  }

  depends_on = [kubernetes_cluster_role.deployment]
}