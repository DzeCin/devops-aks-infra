resource "azurerm_resource_group" "rg" {
  name     = var.rg-name
  location = var.rg-location
}

resource "azurerm_kubernetes_cluster" "k8s-cluster" {
  name                = var.k8s-cluster-name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.k8s-cluster-name
  kubernetes_version = var.k8s-version

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = var.k8s-cluster-default-vm-size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.k8s-cluster-tags
}
