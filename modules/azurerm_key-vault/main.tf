data "azurerm_subscription" "primary" {
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {

    for_each = var.kv

  name                        = each.value.kv_name
  location                    = each.value.kv_location
  resource_group_name         = each.value.rg_name
  enabled_for_disk_encryption = each.value.enabled_for_disk_encryption
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = each.value.soft_delete_retention_days
  purge_protection_enabled    = each.value.purge_protection_enabled
  sku_name = each.value.sku_name
  rbac_authorization_enabled = each.value.rbac_authorization_enabled

  
# dynamic "access_policy" {

#   for_each =each.value.access_policy

#   content {
 
#     tenant_id = data.azurerm_client_config.current.tenant_id
#     object_id = data.azurerm_client_config.current.object_id

#     key_permissions = access_policy.value.key_permissions
#     secret_permissions =access_policy.value.secret_permissions
#     storage_permissions =access_policy.value.storage_permissions
#   }
# }
}
resource "azurerm_role_assignment" "kv-role" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id

lifecycle {
  ignore_changes = all
}


}
