variable "sql_db" {

type =map(object({

sql_db_name        = string
  # server_id    = string
  collation    = string
  license_type = string
  max_size_gb  = number
  sku_name     = string
  enclave_type = string
  tags = map(string)
  server_key =string
  sql_server_name =string
  rg_name =string

}))

}
# variable "server_id"{}