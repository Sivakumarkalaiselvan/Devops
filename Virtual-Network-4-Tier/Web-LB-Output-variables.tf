# Output Load balancer id 
output "web_lb_id"{
    description = "Load Balancer id"
    value = azurerm_lb.web_lb.id
}

# Load Balancer frontend ip's
output "web_lb_frontend_ip"{
    description = "Load balancer frontend ip's"
    value = [azurerm_lb.web_lb.frontend_ip_configuration]
}

# Probe id 
output "web_lb_probe"{
    description = "load balancer probe id "
    value = azurerm_lb_probe.web_lb_probe.id
}