# Input Varibales for app web vmss nsg rule
variable "web_linux_vmss_nsg_inbound_ports"{
    description = "app Web VMSS NSG Inbound Ports"
    type = list(string)
    default = [80, 22, 443]
}


