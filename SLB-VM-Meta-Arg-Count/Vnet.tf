# Resource - 1 Creating Virtual Network
resource "azurerm_virtual_network" "Vnet_1" {
  name = "vnet-1"
  address_space = ["10.0.0.0/16"]            # [] - LIST 
  resource_group_name = azurerm_resource_group.vnet_rg.name
  location = azurerm_resource_group.vnet_rg.location
}

# Resource - 2 Creating subnet
resource "azurerm_subnet" "subnet_1"{
    name = "subnet-1"
    resource_group_name = azurerm_resource_group.vnet_rg.name
    virtual_network_name = azurerm_virtual_network.Vnet_1.name     #Specify to which Vnet this subnet needs to be associated
    address_prefixes=["10.0.2.0/24"]                    
}

/*# Resource - 3 Public IP Address 
resource "azurerm_public_ip" "pub_ip"{
name = "Public-Ip"
resource_group_name = azurerm_resource_group.vnet_rg.name
location = azurerm_resource_group.vnet_rg.location
allocation_method = "Static"
tags = {
    "Name"="prod"               # Map Argument  {} - Map 
    "Env" = "Az"                #Written to check the tf behaviour (*Upgrade In-Place  ~ change) 
}
}    */

# Resource - 4 Network Interface
resource "azurerm_network_interface" "nic"{
    count = var.siva_vm_instance_count                        # Meta Argument Count Implemented
    name ="Siva-Nic-${count.index}"                                 # 5 diff names 
    resource_group_name = azurerm_resource_group.vnet_rg.name
    location = azurerm_resource_group.vnet_rg.location
    ip_configuration{                   #Block inside block (Internal Block)
        name = "internal"
        subnet_id = azurerm_subnet.subnet_1.id       #Attaching this NIC to the subnet 
        private_ip_address_allocation = "Dynamic"
        #public_ip_address_id = azurerm_public_ip.pub_ip.id
    }
}