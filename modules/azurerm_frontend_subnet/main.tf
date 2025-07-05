resource "azurerm_subnet" "subnetfrontend" {
  name                 = var.fsubnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.subnet_faddress_prefixes
}
