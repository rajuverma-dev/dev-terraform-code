resource "azurerm_public_ip" "fpip" {
  name                = var.fpip_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  allocation_method   = "Static"

}