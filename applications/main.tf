

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.92.0"
    }
  }
}

provider "azurerm" {
  features {}
}


module "k8s-cluster" {
  source = "../modules/k8s-cluster"

  node-pools = [{
    name = "test"
    vm_size = "Standard_D2_v2"
    node_count = 1
  }]
}