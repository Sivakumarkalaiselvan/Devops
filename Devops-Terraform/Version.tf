#Terraform Settings Block
terraform {
    required_version = ">=1.0.0"
    required_providers{
        azurerm={
            source = "hashicorp/azurerm"
            version = ">=4.0.0"
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
# Terraform Backend - To Store State files using Azure Storage Account
backend "azurerm" {
                                                # Empty - We will implement this in Release Pipelines 
} 
} 


# Providers Block
provider "azurerm" {
    features {}
    subscription_id = "0925a1ac-409e-41ec-9dd0-48c1a87205c4"
    tenant_id = "c54b3fa1-db9a-4033-a639-b0ce8c1fdac5"
}