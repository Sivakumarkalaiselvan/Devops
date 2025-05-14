# Resource - 1 Priavte DNS Zone 
resource "azurerm_private_dns_zone" "pvt_dns_zone"{
    name = "sivakumar.com"
    resource_group_name = azurerm_resource_group.rg_1.name
}

# Resource - 2 Associate pvt dns & virtual Network
resource "azurerm_private_dns_zone_virtual_network_link" "pvt_dns_vnet_assoc"{
    name = "${local.resource_name_prefix}-pvt-dms-vnet"
    resource_group_name = azurerm_resource_group.rg_1.name
    private_dns_zone_name = azurerm_private_dns_zone.pvt_dns_zone.name
    virtual_network_id = azurerm_virtual_network.vnet.id
}

# Resource - 3 Private DNS Zone A record
resource "azurerm_private_dns_a_record" "pvt_dns_a_record"{
    depends_on = [azurerm_lb.web_lb]
    name = "weblb"
    resource_group_name = azurerm_resource_group.rg_1.name
    zone_name = azurerm_private_dns_zone.pvt_dns_zone.name
    ttl = 300
    records = [azurerm_public_ip.web_lb_pub_ip.name]      # If it consists of dynamic ip address
}