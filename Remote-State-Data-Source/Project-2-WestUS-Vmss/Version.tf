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
# Terraform Backend - To Store State files using Azure Storage Account
backend "azurerm" {
  resource_group_name = "tf-rg"
  storage_account_name = "terraformstorage30"
  container_name = "terraformtfstate"
  key = "project-2-westus-vmss-terraform.tfstate"                      # File Name 
}
}


# Providers Block
provider "azurerm" {
    features {}
    subscription_id = "9950ca22-4ad3-4d10-a3e8-7fbbd00944f7"
    tenant_id = "db5b5fc8-c7d5-4cf6-a99d-0073571418a3"
}