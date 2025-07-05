

data "azurerm_key_vault" "kv" {
  name                = var.keyvault_name
  resource_group_name = var.rg_name
}

data "azurerm_key_vault_secret" "sql_username" {
  name         = var.secret_sqlusername
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "sql_password" {
  name         = var.secret_sqlpass
  key_vault_id = data.azurerm_key_vault.kv.id
}


