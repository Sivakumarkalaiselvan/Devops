# Output Values
output "web_vmss_id"{
    description = "Web VMSS ID"
    value = azurerm_linux_virtual_machine_scale_set.web_vmss.id
}