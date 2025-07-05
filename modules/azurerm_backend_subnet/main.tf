resource "azurerm_subnet" "subnetbackend" {
  name                 = var.bsubnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.subnet_baddress_prefixes
}