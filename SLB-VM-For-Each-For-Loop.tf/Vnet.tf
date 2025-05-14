# Resource - 1 Creating Virtual Network
resource "azurerm_virtual_network" "Vnet_2" {
  name = "vnet-2"
  address_space = ["20.0.0.0/16"]            # [] - LIST 
  resource_group_name = azurerm_resource_group.vnet_rg_2.name
  location = azurerm_resource_group.vnet_rg_2.location
}

# Resource - 2 Creating subnet
resource "azurerm_subnet" "subnet_2"{
    name = "subnet-2"
    resource_group_name = azurerm_resource_group.vnet_rg_2.name
    virtual_network_name = azurerm_virtual_network.Vnet_2.name     #Specify to which Vnet this subnet needs to be associated
    address_prefixes=["20.0.2.0/24"]                    
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
resource "azurerm_network_interface" "nic_2"{
    for_each = var.sk_vm_instance_count                        # Meta Argument "for_each" Implemented
    name ="Siva-Nic-${each.key}"                                    # 2 diff names 
    resource_group_name = azurerm_resource_group.vnet_rg_2.name
    location = azurerm_resource_group.vnet_rg_2.location
    ip_configuration{                   #Block inside block (Internal Block)
        name = "internal-2"
        subnet_id = azurerm_subnet.subnet_2.id      #Attaching this NIC to the subnet 
        private_ip_address_allocation = "Dynamic"
        #public_ip_address_id = azurerm_public_ip.pub_ip.id
    }
}