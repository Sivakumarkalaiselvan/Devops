# Virtual Network Output values

#Virtual Network Name 
output "vnet"{
    description = "Print Virtual Network Name"
    value = module.vnet.vnet_name       # argument reference  (Input for resources)
}

output "vnet_name"{
    description = "Print Virtual Network Name"
    value = module.vnet.vnet_subnets      # argument reference  (Input for resources)
}

