variable "kv" {

  type = map(object({

    kv_name                     = string
    kv_location                 = string
    rg_name                     = string
    enabled_for_disk_encryption = bool
    soft_delete_retention_days  = number
    purge_protection_enabled    = bool
sku_name = string
rbac_authorization_enabled =bool

# access_policy = map(object({
# key_permissions = list(string)
# secret_permissions =list(string)
# storage_permissions =list(string)

# }))

  }))

}
