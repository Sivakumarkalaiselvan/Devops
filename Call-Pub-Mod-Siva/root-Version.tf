#Terraform Settings Block
terraform {
    required_version = ">=1.0.0"
    required_providers{
        azurerm={
            source = "hashicorp/azurerm"
            version = ">=3.0.0"
        }
        random={                                   #Random Provider
            source="hashicorp/random"
            version=">=3.0.0"
        }
        null={                               #Null Provider
            source="hashicorp/null"
            version=">=2.0.0"
        }
    }
}
# Terraform Backend - To Store State files using Azure Storage Account

