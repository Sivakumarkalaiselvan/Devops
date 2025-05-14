# Public IP for NAT GW
resource "azurerm_public_ip" "pub_ip_nat_gateway"{
    name = "${local.resource_name_prefix}-natgw-pub_ip"
    resource_group_name = azurerm_resource_group.rg_1.name
    location = azurerm_resource_group.rg_1.location
    allocation_method = "Static"
    sku = "Standard"
}


# Resource - 1 Nat Gateway
resource "azurerm_nat_gateway" "nat_gateway" {
  name = "${local.resource_name_prefix}-nat-gateway"
  location = azurerm_resource_group.rg_1.location
  resource_group_name = azurerm_resource_group.rg_1.name
  sku_name = "Standard"
}

# Resource - 2 NAT & Pub Ip Association
resource "azurerm_nat_gateway_public_ip_association" "nat_pub_ip_asso"{
nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
public_ip_address_id = azurerm_public_ip.pub_ip_nat_gateway.id
}

# Resource - 3 NAT & Sub Association
resource "azurerm_subnet_nat_gateway_association" "subnet_nat_gateway_asso"{
    subnet_id = azurerm_subnet.app_subnet.id
    nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
}