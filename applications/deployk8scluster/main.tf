

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.20.0"
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

  node_pools = var.node_pools
}

module "acr" {
  source = "../../modules/az-container-registry"
  rg_location = var.rg_location
  rg_name = "ACR"
  acr_name = var.acr_name
  k8s_cluster = module.k8s_cluster.kubelet_id
  depends_on = [module.k8s_cluster]
}

