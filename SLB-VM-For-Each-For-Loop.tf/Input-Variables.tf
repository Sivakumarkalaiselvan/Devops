# Sk VM Instance count with for_each with map of stings or set of strings
variable "sk_vm_instance_count"{
    description = "Insatnce count of that respctive resources"
    type = map(string)
    default = {
        "sk1"="2000"
        "sk2"="3000"
    }
}

