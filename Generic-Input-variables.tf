#Input Variables 
# 1. Business Division    2. Environment varaible 
#Business Division

variable "Business_Division"{
    description = "On which Dept this resource belongs to"
    type = string                    # String , list(String), map (String), boolean 
    default = "HR"
}

#Environment Variable
variable "Environment_Variable"{
    description = "Adding this as a suffix while creating resources"
    type = string
    default= "Dev"
}

#Common Generic Input Varibales 

#Resource Group Name 
variable "resource_group_name"{
description = "resource group name"
type = string
default = "resgrp"
}

#Resource Group Locatiom
variable "resource_group_location"{
    description = "resource group location"
    type = string
    default = "eastus"
}