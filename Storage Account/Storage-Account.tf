# Terraform settings block
terraform{
    required_version=">=1.0.0"
    required_providers{
        azurerm={
            source="hashicorp/azurerm"
            version=">=2.0.0"
        }
        random={                                     #Random Provider
            source="hashicorp/random"
            version=">=3.0.0"
        }
    }
}

# Providers Block
provider "azurerm"{
    subscription_id ="9950ca22-4ad3-4d10-a3e8-7fbbd00944f7"
    features {}        
}

#Resource - 1 Random String Resource
resource "random_string" "my_random"{
    length = 16
    special = false
    upper = false
}

# Resource - 2 Resource Group
resource "azurerm_resource_group" "sa_rg"{
    name = "sa-rg"
    location= "Central India"
}

# Resource - 3 Storage Account

resource "azurerm_storage_account" "sa"{                                  # Top level Blocks
    name = "sa${random_string.my_random.id}"
    resource_group_name = azurerm_resource_group.sa_rg.name
    location = azurerm_resource_group.sa_rg.location
    account_tier = "Standard"
    account_replication_type = "GRS"
    tags={
        environment = "Test"                         # Map Argument (This is not a block bcoz we are using = )
    }
    
}