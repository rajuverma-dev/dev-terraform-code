resource "azurerm_key_vault_secret" "sql_username" {
  name         = var.secret_sqlusername
  value        = var.secret_sqlusernamevalue
  key_vault_id = data.azurerm_key_vault.kvdata.id
}

