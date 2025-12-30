variable "kv-secret" {

type = map(object({

kv_name = string
rg_name =string
secret_name =string
secret_value =string


}))

}