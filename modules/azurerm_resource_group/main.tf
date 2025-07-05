resource "azurerm_resource_group" "rgb" {
  name     = var.rg_name
  location = var.rg_location
}