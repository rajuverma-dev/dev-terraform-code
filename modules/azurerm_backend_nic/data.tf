data "azurerm_subnet" "bsubnetdata" {
  name                 = var.bsubnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.rg_name
}



data "azurerm_public_ip" "bpipdata" {
  name                = var.bpip_name
  resource_group_name = var.rg_name
}
