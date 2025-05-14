# Input Varibales for app vmss nsg rule
variable "app_linux_vmss_nsg_inbound_ports"{
    description = "APP VMSS NSG Inbound Ports"
    type = list(string)
    default = [80, 22, 443]
}