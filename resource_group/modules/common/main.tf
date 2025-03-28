locals {
  scope_name = "${var.application_name}-${var.environment_name}"
}

resource "azurerm_resource_group" "main" {
  name     = "rg-${local.scope_name}"
  location = var.location
}
