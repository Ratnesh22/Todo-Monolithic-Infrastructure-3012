data "azurerm_public_ip" "pip" {
  for_each            = var.host
  name                = each.value.pip_name
  resource_group_name = each.value.rg_name
}
data "azurerm_subnet" "subnets" {
  for_each             = var.host
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rg_name
}

resource "azurerm_bastion_host" "ToDo-Frontend" {

for_each =var.host

  name                = each.value.host_name
  location            = each.value.rg_location
  resource_group_name = each.value.rg_name

  dynamic  "ip_configuration" {

    for_each = each.value.ip_configuration

    content {
    name                 = ip_configuration.value.ip_name
    subnet_id            = data.azurerm_subnet.subnets[each.key].id
    public_ip_address_id = data.azurerm_public_ip.pip[each.key].id
  }
}
}