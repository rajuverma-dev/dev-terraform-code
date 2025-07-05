module "resource_group" {
  source      = "../modules/azurerm_resource_group"
  rg_name     = var.rg_name
  rg_location = var.rg_location
}

module "resource_groupA" {
  source      = "../modules/azurerm_resource_group"
  rg_name     = var.rg_name1
  rg_location = var.rg_location1
}

module "key_vault" {
  depends_on    = [module.resource_group]
  source        = "../modules/azurerm_key_vault"
  rg_name       = var.rg_name
  rg_location   = var.rg_location
  keyvault_name = var.keyvault_name
}

module "sql_username" {
  depends_on              = [module.resource_group, module.key_vault]
  source                  = "../modules/azurerm_sql_user_secret"
  secret_sqlusername      = var.secret_sqlusername
  secret_sqlusernamevalue = var.secret_sqlusernamevalue
  rg_name                 = var.rg_name
  keyvault_name           = var.keyvault_name

}

module "sql_password" {
  depends_on          = [module.resource_group, module.key_vault]
  source              = "../modules/azurerm_sql_pass_secret"
  secret_sqlpass      = var.secret_sqlpass
  secret_sqlpassvalue = var.secret_sqlpassvalue
  rg_name             = var.rg_name
  keyvault_name       = var.keyvault_name

}

module "vm_user" {
  depends_on         = [module.resource_group, module.key_vault]
  source             = "../modules/azurerm_vm_user_secret"
  secret_vmuser      = var.secret_vmuser
  secret_vmuservalue = var.secret_vmuservalue
  rg_name            = var.rg_name
  keyvault_name      = var.keyvault_name

}

module "vm_password" {
  depends_on         = [module.resource_group, module.key_vault]
  source             = "../modules/azurerm_vm_pass_secret"
  secret_vmpass      = var.secret_vmpass
  secret_vmpassvalue = var.secret_vmpassvalue
  rg_name            = var.rg_name
  keyvault_name      = var.keyvault_name

}

module "virtual_network" {
  depends_on           = [module.resource_group]
  source               = "../modules/azurerm_virtual_network"
  virtual_network_name = var.virtual_network_name
  rg_name              = var.rg_name
  rg_location          = var.rg_location
  vnet_address_space   = var.vnet_address_space
}

module "subnetfrontend" {
  depends_on               = [module.virtual_network, module.resource_group]
  source                   = "../modules/azurerm_frontend_subnet"
  fsubnet_name             = var.fsubnet_name
  rg_name                  = var.rg_name
  rg_location              = var.rg_location
  virtual_network_name     = var.virtual_network_name
  subnet_faddress_prefixes = var.subnet_faddress_prefixes
}

module "subnetbackend" {
  depends_on               = [module.virtual_network, module.resource_group]
  source                   = "../modules/azurerm_backend_subnet"
  bsubnet_name             = var.bsubnet_name
  rg_name                  = var.rg_name
  rg_location              = var.rg_location
  virtual_network_name     = var.virtual_network_name
  subnet_baddress_prefixes = var.subnet_baddress_prefixes
}

module "sql_server" {
  depends_on      = [module.resource_group, module.key_vault, module.sql_username, module.sql_password]
  source          = "../modules/azurerm_sql_server"
  sql_server_name = var.sql_server_name
  rg_name         = var.rg_name
  rg_location     = var.rg_location
  keyvault_name   = var.keyvault_name
  secret_sqlusername  = var.secret_sqlusername
  secret_sqlpass = var.secret_sqlpass

}

module "database" {
  depends_on      = [module.sql_server]
  source          = "../modules/azurerm_database"
  database_name   = var.database_name
  sql_server_name = var.sql_server_name
  rg_name         = var.rg_name
}

module "network_interface-frontend" {
  depends_on           = [module.resource_group, module.subnetfrontend, module.pip_frontend]
  source               = "../modules/azurerm_frontend_nic"
  fnic_name            = var.fnic_name
  rg_name              = var.rg_name
  rg_location          = var.rg_location
  fpip_name            = var.fpip_name
  fsubnet_name         = var.fsubnet_name
  virtual_network_name = var.virtual_network_name
}

module "network_interface-backend" {
  depends_on           = [module.resource_group, module.subnetbackend, module.pip_backend]
  source               = "../modules/azurerm_backend_nic"
  bnic_name            = var.bnic_name
  rg_name              = var.rg_name
  rg_location          = var.rg_location
  bpip_name            = var.bpip_name
  bsubnet_name         = var.bsubnet_name
  virtual_network_name = var.virtual_network_name
}

module "pip_frontend" {
  depends_on  = [module.resource_group]
  source      = "../modules/azurerm_frontend_pip"
  rg_name     = var.rg_name
  rg_location = var.rg_location
  fpip_name   = var.fpip_name
}

module "pip_backend" {
  depends_on  = [module.resource_group]
  source      = "../modules/azurerm_backend_pip"
  rg_name     = var.rg_name
  rg_location = var.rg_location
  bpip_name   = var.bpip_name
}

module "virtual_machine-frontend" {
  depends_on         = [module.subnetfrontend, module.network_interface-frontend, module.key_vault, module.vm_user, module.vm_password]
  source             = "../modules/azurerm_frontend_vm"
  rg_name            = var.rg_name
  rg_location        = var.rg_location
  fvm_name           = var.fvm_name
  vm_size            = var.vm_size
  vm_image_publisher = var.vm_image_publisher
  vm_image_offer     = var.vm_image_offer
  vm_image_sku       = var.vm_image_sku
  vm_image_version   = var.vm_image_version
  fnic_name          = var.fnic_name
  fpip_name          = var.fpip_name
  vm_user_name       = var.vm_user_name
  keyvault_name      = var.keyvault_name
  secret_vmuser = var.secret_vmuser
  secret_vmpass      = var.secret_vmpass
  secret_vmpassvalue = var.secret_sqlpassvalue

}

module "virtual_machine-backend" {
  depends_on         = [module.resource_group, module.network_interface-backend, module.key_vault, module.vm_user, module.vm_password]
  source             = "../modules/azurerm_backend_vm"
  rg_name            = var.rg_name
  rg_location        = var.rg_location
  bvm_name           = var.bvm_name
  vm_size            = var.vm_size
  vm_image_publisher = var.vm_image_publisher
  vm_image_offer     = var.vm_image_offer
  vm_image_sku       = var.vm_image_sku
  vm_image_version   = var.vm_image_version
  bnic_name          = var.bnic_name
  bpip_name          = var.bpip_name
  keyvault_name      = var.keyvault_name
  vm_user_name       = var.vm_user_name
  secret_vmuser      = var.secret_vmuser
  secret_vmpass      = var.secret_vmpass
}
