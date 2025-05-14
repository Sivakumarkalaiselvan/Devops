#Input varaibles for vnet name 
variable "vnet_name"{
    description ="virtual network name"
    type = string
    default = "Vnet-New"
}

# Input var for vnet address
variable "vnet_address"{
    description = "Virtual Network Address Allocation"
    type = list(string)
    default = ["10.0.0.0/16"]
}

# Input var for web subnet name 
variable "web_subnet_name"{
    description = "web subnet name"
    type = string
    default = "web-subnet"
}

#Input var for web subnet address
variable "web_subnet_address"{
    description = "web subnet address space"
    type = list(string)
    default = ["10.0.1.0/24"]
}

# Input var for app subnet name 
variable "app_subnet_name"{
    description = "app subnet name"
    type = string
    default = "app-subnet"
}

#Input var for app subnet address
variable "app_subnet_address"{
    description = "app subnet address space"
    type = list(string)
    default = ["10.0.5.0/24"]
}

# Input var for db subnet name 
variable "db_subnet_name"{
    description = "db subnet name"
    type = string
    default = "db-subnet"
}

#Input var for db  subnet address
variable "db_subnet_address"{
    description = "db subnet address space"
    type = list(string)
    default = ["10.0.10.0/24"]
}


# Input var for bastion host subnet name 
variable "bastion_host_subnet_name"{
    description = "bastion host subnet name"
    type = string
    default = "bastion-host-subnet"
}

#Input var for bastion host  subnet address
variable "bastion_host_subnet_address"{
    description = "bastion host subnet address space"
    type = list(string)
    default = ["10.0.101.0/24"]
}
