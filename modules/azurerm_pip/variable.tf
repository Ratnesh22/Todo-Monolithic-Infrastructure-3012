variable "public_ip" {
  type = map(object({


    pip_name          = string
    rg_name           = string
    rg_location       = string
    allocation_method = string
    sku               = optional(string, "Standard")
    tags              = optional(map(string))

  }))


}
