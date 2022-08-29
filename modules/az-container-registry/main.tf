resource "azurerm_resource_group" rg {
  name     = var.rg_name
  location = var.rg_location
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Premium"
  admin_enabled       = true
}


resource "azurerm_role_assignment" "ara_pull" {
  principal_id                     = var.k8s_cluster
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "ara_push" {
  principal_id                     = var.k8s_cluster
  role_definition_name             = "AcrPush"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}
