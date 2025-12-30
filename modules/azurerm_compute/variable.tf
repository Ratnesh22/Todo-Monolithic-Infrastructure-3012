variable "compute" {
type = map(object({

subnet_name =string
vnet_name =string
rg_name =string
nic_name =string
rg_location =string
pip_name =string
kv_name =string
admin_username =string
admin_password =string
ip_config =map(object({
    name =string
    private_ip_address_allocation =string
}))
vm_name =string
vm_size =string
# vm_username =string
# vm_password =string
disable_password_authentication =bool

os_disk =map(object({
caching =string
storage_account_type =string
}))
source_image_reference =map(object({
publisher =string
offer =string
sku =string
version =string
}))

}))

}