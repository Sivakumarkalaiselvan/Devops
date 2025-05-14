# Azure Bastion Service Subnet
/*resource "azurerm_subnet" "bastion_service_subnet"{
    name =var.bastion_service_subnet_name
    resource_group_name = azurerm_resource_group.rg_1.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = var.bastion_service_address_prefix
}

# Bastion Service Public Ip
resource "azurerm_public_ip" "bastion_service_public_ip" {
    name = "${local.resource_name_prefix}-bastion-service-publicip"
    resource_group_name = azurerm_resource_group.rg_1.name
    location = azurerm_resource_group.rg_1.location
    allocation_method = "Static"
    sku = "Standard"
}

# Resource : Bastion Host Service 
resource "azurerm_bastion_host" "bastion_service_resource"{
    name = "${local.resource_name_prefix}-bastion-host-service"
    resource_group_name = azurerm_resource_group.rg_1.name
    location = azurerm_resource_group.rg_1.location
    sku = "Standard"
    ip_configuration {
      name = "bastion-ip-1"
      subnet_id = azurerm_subnet.bastion_service_subnet.id
      public_ip_address_id = azurerm_public_ip.bastion_service_public_ip.id
    }
} */