resource "azurerm_key_vault_secret" "vm_username" {
  name         = var.secret_vmuser
  value        = var.secret_vmuservalue
  key_vault_id = data.azurerm_key_vault.kvdata.id
}
