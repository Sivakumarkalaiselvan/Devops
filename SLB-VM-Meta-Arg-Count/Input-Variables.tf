# Siva VM Instance count
variable "siva_vm_instance_count"{
description = "instance count for siva vm"
type = number
default = 2
}

# Inbound NAT Rules for all the 5 vm's
variable "sivavm_inbound_nat_rules"{
    description = "Inbound NAT Rules for all the vm's"
    type = list(string)
    default=["1022","2022","3022","4022","5022"]
}
