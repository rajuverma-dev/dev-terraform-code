

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.fvm_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  size                = var.vm_size
  admin_username      = data.azurerm_key_vault_secret.vmuservalue.value
  admin_password = data.azurerm_key_vault_secret.vmpassvalue.value
  network_interface_ids = [
    data.azurerm_network_interface.fnicdata.id,
  ]
  disable_password_authentication = false


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.vm_image_publisher
    offer     = var.vm_image_offer
    sku       = var.vm_image_sku
    version   = var.vm_image_version
  }

  custom_data = base64encode(<<EOF
#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
EOF
  )
}
