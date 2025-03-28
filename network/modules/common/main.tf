data "azurerm_resource_group" "main" {
  name = "rg-${var.application_name}-${var.environment_name}"
}

resource "azurerm_virtual_network" "main" {
  name                = "vnet-${var.application_name}-${var.environment_name}"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  address_space = [var.address_space]
}
