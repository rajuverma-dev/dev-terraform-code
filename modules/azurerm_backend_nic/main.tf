resource "azurerm_network_interface" "bnicb" {
  name                = var.bnic_name
  location            = var.rg_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.bsubnetdata.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = data.azurerm_public_ip.bpipdata.id
  }
}