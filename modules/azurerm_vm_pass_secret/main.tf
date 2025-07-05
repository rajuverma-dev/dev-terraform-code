resource "azurerm_key_vault_secret" "vm_password" {
  name         = var.secret_vmpass
  value        = var.secret_vmpassvalue
  key_vault_id = data.azurerm_key_vault.kvdata.id
}
