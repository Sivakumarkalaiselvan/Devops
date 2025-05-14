# Input Varibales for app1 vmss nsg rule
variable "app1_linux_vmss_nsg_inbound_ports"{
    description = "APP 1 VMSS NSG Inbound Ports"
    type = list(string)
    default = [80, 22, 443]
}


# Input Varibales for app 2 vmss nsg rule
variable "app2_linux_vmss_nsg_inbound_ports"{
    description = "APP 2 VMSS NSG Inbound Ports"
    type = list(string)
    default = [80, 22, 443]
}