data "azurerm_key_vault" "kv" {

    for_each = var.compute
  name                = each.value.kv_name
  resource_group_name = each.value.rg_name
}

data "azurerm_key_vault_secret" "admin-username" {

  for_each =var.compute
  name         = each.value.admin_username
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}
data "azurerm_key_vault_secret" "admin-password" {

  for_each =var.compute
  name         = each.value.admin_password
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}


data "azurerm_subnet" "subnets" {
  for_each             = var.compute
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rg_name
}
data "azurerm_public_ip" "pip" {
  for_each            = var.compute
  name                = each.value.pip_name
  resource_group_name = each.value.rg_name
}

resource "azurerm_network_interface" "todo-nic" {
  for_each = var.compute

  name                = each.value.nic_name
  location            = each.value.rg_location
  resource_group_name = each.value.rg_name

  dynamic "ip_configuration" {

    for_each = each.value.ip_config
    content {
      name                          = ip_configuration.value.name
      subnet_id                     = data.azurerm_subnet.subnets[each.key].id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      public_ip_address_id          = data.azurerm_public_ip.pip[each.key].id

    }

  }
}



resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.compute

  name                            = each.value.vm_name
  resource_group_name             = each.value.rg_name
  location                        = each.value.rg_location
  size                            = each.value.vm_size
  admin_username                  = data.azurerm_key_vault_secret.admin-username[each.key].value
  admin_password                  = data.azurerm_key_vault_secret.admin-password[each.key].value
  network_interface_ids           = [azurerm_network_interface.todo-nic[each.key].id]
  disable_password_authentication = each.value.disable_password_authentication


  dynamic "os_disk" {
    for_each = each.value.os_disk
    content {
      caching              = os_disk.value.caching
      storage_account_type = os_disk.value.storage_account_type
    }
  }
  dynamic "source_image_reference" {
    for_each = each.value.source_image_reference
    content {
      publisher = source_image_reference.value.publisher
      offer     = source_image_reference.value.offer
      sku       = source_image_reference.value.sku
      version   = source_image_reference.value.version
    }
  }

custom_data = base64encode(<<EOF

# Update packages
sudo apt-get update -y

# Install NGINX, Python3 and pip3
sudo apt-get install -y nginx python3 python3-pip

# Enable and start NGINX
sudo systemctl enable nginx
sudo systemctl start nginx

# Upgrade pip
sudo pip3 install --upgrade pip

EOF
)

}
