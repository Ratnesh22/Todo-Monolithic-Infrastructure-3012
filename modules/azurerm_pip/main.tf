resource "azurerm_public_ip" "todo-pip" {

  for_each = var.public_ip

  name                = each.value.pip_name
  resource_group_name = each.value.rg_name
  location            = each.value.rg_location
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
  tags                = each.value.tags

}
