data "azurerm_key_vault" "kv" {

    for_each = var.kv-secret
  name                = each.value.kv_name
  resource_group_name = each.value.rg_name
}

resource "azurerm_key_vault_secret" "kv-secret" {

for_each = var.kv-secret

  name         = each.value.secret_name
  value        = each.value.secret_value
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}