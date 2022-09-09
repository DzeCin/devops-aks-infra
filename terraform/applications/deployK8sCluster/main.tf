terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.21.1"
    }
  }
}


provider "azurerm" {
  features {}
}


module "k8s_cluster" {
  source = "../../modules/k8s-cluster"
  rg_location = var.rg_location
  rg_name = var.rg_name
  k8s_cluster_name = var.k8s_cluster_name
  log_analytics_workspace_id = var.log_analytics_workspace_id
  node_pools = var.node_pools
  event_hub_name = var.event_hub_name
  event_hub_namespace_rg_name = var.event_hub_namespace_rg_name
  event_hub_namespace_name = var.event_hub_namespace_name
}

module "acr" {
  source = "../../modules/az-container-registry"
  rg_location = var.rg_location
  rg_name = "ACR"
  acr_name = var.acr_name
  k8s_cluster = module.k8s_cluster.kubelet_id
  depends_on = [module.k8s_cluster]
}

