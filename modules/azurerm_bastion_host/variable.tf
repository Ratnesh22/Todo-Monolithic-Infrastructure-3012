variable "host" {

type =map (object({

pip_name =string
rg_name =string
subnet_name =string
vnet_name =string
host_name =string
rg_location =string
ip_configuration =map(object({
ip_name =string

}))


}))





}