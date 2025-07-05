resource "azurerm_key_vault_secret" "sql_pass" {
  name         = var.secret_sqlpass
  value        = var.secret_sqlpassvalue
  key_vault_id = data.azurerm_key_vault.kvdata.id
}
