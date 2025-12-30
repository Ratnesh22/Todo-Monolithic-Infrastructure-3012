rgs = {

  rg1 = {
    name       = "ratnesh-rg-1"
    location   = "Central India"
    managed_by = "ratnesh"
    tags = {
      environment = "dev"
      project     = "todo-app"
    }
  }
  # rg2 = {
  #   name     = "ratnesh-rg-2"
  #   location = "Central India"
  #   # rg_managed_by = null
  #   tags = {
  #     environment = "dev"
  #     project     = "todo-app"
  #   }
  # }
}
vnet = {
  vnet1 = {

    name                = "vnet-1"
    location            = "Central India"
    resource_group_name = "ratnesh-rg-1"
    address_space       = ["10.0.0.0/16"]
    dns_servers         = ["10.0.0.4", "10.0.0.5"]
    subnets = [
      {
        name             = "frontend-subnet"
        address_prefixes = ["10.0.1.0/24"]
      },
      {
        name             = "backend-subnet"
        address_prefixes = ["10.0.2.0/24"]
      }
      ,
      {
        name             = "AzureBastionSubnet"
        address_prefixes = ["10.0.3.0/24"]
      }
    ]
  }

  # vnet2 = {

  #   name                = "vnet-2"
  #   location            = "Central India"
  #   resource_group_name = "ratnesh-rg-2"
  #   address_space       = ["10.1.0.0/16"]
  #   dns_servers         = ["10.0.0.4", "10.0.0.5"]
  #   subnets = [
  #     {
  #       name             = "subnet-1"
  #       address_prefixes = ["10.1.1.0/24"]
  #     },
  #     {
  #       name             = "subnet-2"
  #       address_prefixes = ["10.1.2.0/24"]
  #     }
  #   ]
  # }
}

public_ip = {
  pip1 = {
    pip_name          = "frontend-pip"
    rg_name           = "ratnesh-rg-1"
    rg_location       = "Central India"
    allocation_method = "Static"
    sku               = "Standard"
    tags = {
      environment = "dev"
      project     = "todo-app"
    }
  }
  pip2 = {
    pip_name          = "backend-pip"
    rg_name           = "ratnesh-rg-1"
    rg_location       = "Central India"
    allocation_method = "Static"
    # sku                 = null
    tags = {
      environment = "dev"
      project     = "todo-app"
    }
  }
}
sql_server = {
  server1 = {

    sql_server_name    = "rksqlserver2026"
    rg_name            = "ratnesh-rg-1"
    rg_location        = "Central India"
    sql_server_version = "12.0"
    minimum_tls_version  = "1.2"
    kv_name              = "ratneshkeyvault31122025"
    admin-username = "server-admin-username"
    admin-password = "server-admin-password"
    public_network_access_enabled =false
    tags = {
      environment = "dev"
      project     = "todo-app"

    }
  }

}
sql_db = {

  db1 = {

    sql_db_name = "mysqldb_2025"
    collation    = "SQL_Latin1_General_CP1_CI_AS"
    license_type = "LicenseIncluded"
    max_size_gb  = 2
    sku_name     = "S0"
    enclave_type = "VBS"
    server_key   = "server1"
    sql_server_name ="rksqlserver2026"
    rg_name ="ratnesh-rg-1"
    tags = {
      environment = "dev"
      project     = "todo-app"
    }



  }

}
compute = {
  compute1 = {
    subnet_name = "frontend-subnet"
    vnet_name   = "vnet-1"
    rg_name     = "ratnesh-rg-1"
    kv_name     = "ratneshkeyvault31122025"
    nic_name    = "frontend-nic"
    rg_location = "Central India"
    pip_name    = "frontend-pip"
    ip_config = {
      ip_config1 = {
        name                          = "frontend-ip_config"
        private_ip_address_allocation = "Dynamic"
    } }
    vm_name = "frontend-vm"
    vm_size = "Standard_D2s_v3"
    admin_username            = "frontend-vm-admin-username"
    admin_password            = "frontend-vm-admin-password"
    disable_password_authentication = "false"

    os_disk = {
      os_disk1 = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    } }
    source_image_reference = {
      source_image_reference1 = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
    } }
  }
  compute2 = {
    subnet_name = "backend-subnet"
    vnet_name   = "vnet-1"
    rg_name     = "ratnesh-rg-1"
    kv_name     = "ratneshkeyvault31122025"
    nic_name    = "backend-nic"
    rg_location = "Central India"
    pip_name    = "backend-pip"
    ip_config = {
      ip_config1 = {
        name                          = "backend-ip_config"
        private_ip_address_allocation = "Dynamic"
    } }
    vm_name = "backend-vm"
    vm_size = "Standard_D2s_v3"
    admin_username            = "backend-vm-admin-username"
    admin_password            = "backend-vm-admin-password"
    disable_password_authentication = "false"

    os_disk = {
      os_disk1 = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    } }
    source_image_reference = {
      source_image_reference1 = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
    } }
  }
}

kv = {


  kv1 = {

    kv_name                     = "ratneshkeyvault31122025"
    kv_location                 = "Central India"
    rg_name                     = "ratnesh-rg-1"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    sku_name                    = "standard"
    rbac_authorization_enabled =true
    # access_policy = {
    #   ap1 = {
    #     key_permissions     = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey", "Verify", "Sign", "Purge", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
    #     secret_permissions  = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"]
    #     storage_permissions = ["Get"]

    #   }
    # }
  }
}
kv-secret = {


  kv-secret1 = {
    kv_name      = "ratneshkeyvault31122025"
    rg_name      = "ratnesh-rg-1"
    secret_name  = "server-admin-username"
    secret_value = "mysqlserver@admin"

  }
  kv-secret2 = {
    kv_name      = "ratneshkeyvault31122025"
    rg_name      = "ratnesh-rg-1"
    secret_name  = "server-admin-password"
    secret_value = "Qwerty@123456"

  }

  kv-secret3 = {
    kv_name      = "ratneshkeyvault31122025"
    rg_name      = "ratnesh-rg-1"
    secret_name  = "frontend-vm-admin-username"
    secret_value = "myfrontendvm@admin"

  }
  kv-secret4 = {
    kv_name      = "ratneshkeyvault31122025"
    rg_name      = "ratnesh-rg-1"
    secret_name  = "frontend-vm-admin-password"
    secret_value = "Qwerty@123456"

  }
  kv-secret5 = {
    kv_name      = "ratneshkeyvault31122025"
    rg_name      = "ratnesh-rg-1"
    secret_name  = "backend-vm-admin-username"
    secret_value = "mybackendvm@admin"

  }
  kv-secret6 = {
    kv_name      = "ratneshkeyvault31122025"
    rg_name      = "ratnesh-rg-1"
    secret_name  = "backend-vm-admin-password"
    secret_value = "Qwerty@123456"

  }
}
nsg ={

  nsg1 ={
nsg_name ="dev_frontend_nsg_name"
rg_location ="Central India"
rg_name ="ratnesh-rg-1"
tags ={
environment = "dev"
      project     = "todo-app"
    }
security_rule ={
  security_rule1 ={
name ="dev_frontend_test123"
priority =100
direction ="Inbound"
access ="Allow"
protocol ="Tcp"
source_port_range ="22"
destination_port_range ="80"
source_address_prefix ="*"
destination_address_prefix ="*"

}
}
  }
  nsg2 ={
nsg_name ="dev_backend_nsg_name"
rg_location ="Central India"
rg_name ="ratnesh-rg-1"
tags ={
environment = "dev"
      project     = "todo-app"
    }
security_rule ={
  security_rule2 ={
name ="dev_backend_test123"
priority =100
direction ="Inbound"
access ="Allow"
protocol ="Tcp"
source_port_range ="22"
destination_port_range ="80"
source_address_prefix ="*"
destination_address_prefix ="*"

}
}
  }
}
host ={

  host1 ={

pip_name ="frontend-pip"
rg_name ="ratnesh-rg-1"
subnet_name ="AzureBastionSubnet"
vnet_name ="vnet-1"
host_name ="ratnesh-bastion-host"
rg_location ="Central India"
ip_configuration ={
  ip-conf1 ={

  ip_name ="frontend-ip_config"

  }
}
  }
  
  }