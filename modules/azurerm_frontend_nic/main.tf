resource "azurerm_network_interface" "fnicb" {
  name                = var.fnic_name
  location            = var.rg_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.fsubnetdata.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = data.azurerm_public_ip.fpipdata.id
  }
}