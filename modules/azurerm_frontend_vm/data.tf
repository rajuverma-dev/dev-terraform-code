


data "azurerm_network_interface" "fnicdata" {
  name                = var.fnic_name
  resource_group_name = var.rg_name
}
data "azurerm_key_vault" "kv" {
  name                = var.keyvault_name
  resource_group_name = var.rg_name
}

data "azurerm_key_vault_secret" "vmuservalue" {
  name         = var.secret_vmuser
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "vmpassvalue" {
  name         = var.secret_vmpass
  key_vault_id = data.azurerm_key_vault.kv.id
}

