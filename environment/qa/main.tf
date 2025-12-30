module "azurerm_resource_group" {
source = "../../modules/azurerm_resource_group"
rgs= var.rgs

}
module "azurerm_key-vault" {

depends_on = [module.azurerm_resource_group]
source = "../../modules/azurerm_key-vault"
kv = var.kv

}
module "azurerm_key-vault_secret" {

depends_on = [ module.azurerm_key-vault ]
source ="../../modules/azurerm_key-vault_secret"
kv-secret =var.kv-secret

}
module "azurerm_networking_infra" {
  depends_on = [ module.azurerm_resource_group ]
    source = "../../modules/azurerm_networking_infra"
    vnet = var.vnet
}
module "azurerm_pip" {
  depends_on = [ module.azurerm_resource_group ]
  source = "../../modules/azurerm_pip"
  public_ip = var.public_ip
}
module "azurerm_mssql_server" {
  depends_on = [ module.azurerm_resource_group,module.azurerm_key-vault_secret]
  source = "../../modules/azurerm_sql_server"
  sql_server= var.sql_server

}
module "azurerm_sql_db" {

  depends_on = [ module.azurerm_mssql_server ]
  source = "../../modules/azurerm_sql_db"
  sql_db =var.sql_db
  # server_id = module.azurerm_mssql_server.sql_server_id
}
module "azurerm_compute" {
  
  depends_on = [ module.azurerm_pip,module.azurerm_key-vault_secret ]
  source = "../../modules/azurerm_compute"
  compute =var.compute
}

module "azurerm_network_security_group" {

depends_on = [ module.azurerm_resource_group ]
source = "../../modules/azurerm_network_security_group"
nsg =var.nsg
}
module "azurerm_bastion_host" {

depends_on = [ module.azurerm_networking_infra,module.azurerm_pip,module.azurerm_compute ]
source = "../../modules/azurerm_bastion_host"
host =var.host
}