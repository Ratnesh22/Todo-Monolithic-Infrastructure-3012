variable "sql_server" {
  type = map(object({

    sql_server_name           = string
    rg_name                   = string
    rg_location               = string
    sql_server_version        = string
    # sql_server_admin_login    = string
    # sql_server_admin_password = string
    minimum_tls_version       = string
    public_network_access_enabled =bool
    tags                      = map(string)
    kv_name =string
    admin-username =string
    admin-password =string

  }))

}
