# Execute remote state data source to get the pro-1 & pro-2 info in another file

# Remote state data source : project-1
data "terraform_remote_state" "project_1"{
    backend = "azurerm"
    config = {
    resource_group_name = "tf-rg"
    storage_account_name = "terraformstorage30"
    container_name = "terraformtfstate"
    key = "project-1-eastus-vmss-terraform.tfstate" 
    }
}

# # Remote state data source : project-2 
data "terraform_remote_state" "project_2"{
    backend = "azurerm"
    config = {
    resource_group_name = "tf-rg"
    storage_account_name = "terraformstorage30"
    container_name = "terraformtfstate"
    key = "project-2-westus-vmss-terraform.tfstate" 
    }
}