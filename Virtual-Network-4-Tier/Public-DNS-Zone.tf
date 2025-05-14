# Resource : Data Source for Public DNS 
data "azurerm_dns_zone" "public_dns_zone"{
    name = "docker.com"                               # Data Source : To acess the info of an existing dns reso already created
    resource_group_name = "dns-rg"
}

# Resource : Create Record Sets for Public DNS Zone
resource "azurerm_dns_a_record" "dns_a_record"{
    zone_name = data.azurerm_dns_zone.public_dns_zone.name
    resource_group_name = data.azurerm_dns_zone.public_dns_zone.resource_group_name
    name = "@"
    ttl = 500
    target_resource_id = azurerm_public_ip.web_lb_pub_ip.id          # Records = [] use can also use this instead of target_resource_id 
}



# Resource : Create www Record Sets for Public DNS Zone
resource "azurerm_dns_a_record" "dns_www_record"{
    zone_name = data.azurerm_dns_zone.public_dns_zone.name
    resource_group_name = data.azurerm_dns_zone.public_dns_zone.resource_group_name
    name = "www"
    ttl = 500
    target_resource_id = azurerm_public_ip.web_lb_pub_ip.id          # Records = [] use can also use this instead of target_resource_id
}

