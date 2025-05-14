# Input Varaibles for Bastion service Subnet
variable "bastion_service_subnet_name"{
    description = "Bastion service subnet name"
    default = "AzureBastionSubnet"
}


# Input variables for bastion service subnet add prefix
variable "bastion_service_address_prefix"{
    description = "azure bastiomn service address prefixes"
    type = list(string)
    default = ["10.0.8.0/24"]
}


