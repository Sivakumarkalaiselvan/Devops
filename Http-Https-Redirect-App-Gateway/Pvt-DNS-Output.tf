# Web app FQDN
output "fqdn_weblb"{
   description = "web-lb FQDN"
   value = azurerm_private_dns_a_record.pvt_dns_a_record.fqdn
}