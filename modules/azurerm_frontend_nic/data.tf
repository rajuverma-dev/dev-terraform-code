data "azurerm_subnet" "fsubnetdata" {
  name                 = var.fsubnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.rg_name
}



data "azurerm_public_ip" "fpipdata" {
  name                = var.fpip_name
  resource_group_name = var.rg_name
}
