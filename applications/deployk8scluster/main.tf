

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.98.0"
    }
  }
}


provider "azurerm" {
  features {}
}


module "k8s-cluster" {
  source = "../../modules/k8s-cluster"
  rg-location = "West Europe"
  rg-name = "K8S"
  k8s-cluster-name = "aksdzenan"

  node-pools = [{
    name = "workers"
    vm_size = "Standard_D2_v2"
    node_count = 1
  }]
}

module "acr" {
  rg-location = "West Europe"
  rg-name = "ACR"
  acr-name = "azureacr1dzenancin"
  source = "../../modules/az-container-registry"
  k8s-cluster = module.k8s-cluster.kubelet_id
  depends_on = [module.k8s-cluster]
}

