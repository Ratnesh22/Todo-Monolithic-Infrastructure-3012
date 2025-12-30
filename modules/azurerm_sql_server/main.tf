data "azurerm_key_vault" "kv" {

  for_each = var.sql_server
  name                = each.value.kv_name
  resource_group_name = each.value.rg_name
}

data "azurerm_key_vault_secret" "admin-username" {

  for_each =var.sql_server
  name         = each.value.admin-username
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}
data "azurerm_key_vault_secret" "admin-password" {

  for_each =var.sql_server
  name         = each.value.admin-password
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}


resource "azurerm_mssql_server" "sql_server" {
  for_each                     = var.sql_server
  name                         = each.value.sql_server_name
  resource_group_name          = each.value.rg_name
  location                     = each.value.rg_location
  version                      = each.value.sql_server_version
  administrator_login          = data.azurerm_key_vault_secret.admin-username[each.key].value
  administrator_login_password = data.azurerm_key_vault_secret.admin-password[each.key].value
  minimum_tls_version          = each.value.minimum_tls_version
  public_network_access_enabled = each.value.public_network_access_enabled
  tags                         = each.value.tags
}
