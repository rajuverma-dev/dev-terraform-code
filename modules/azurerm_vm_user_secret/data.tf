data "azurerm_key_vault" "kvdata" {
  name                = var.keyvault_name
  resource_group_name = var.rg_name
}