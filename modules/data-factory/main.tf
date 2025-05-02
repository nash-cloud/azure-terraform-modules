resource "azurerm_data_factory" "adl_adf" {
  name                = "adf-${var.basename}"
  location            = var.location
  resource_group_name = var.resource_group_name

  identity {
    type = "SystemAssigned"
  }

  public_network_enabled          = var.public_network_access_enabled
  managed_virtual_network_enabled = var.managed_virtual_network_enabled

  count = var.module_enabled ? 1 : 0

  tags = var.tags
}