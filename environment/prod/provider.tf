terraform {

 backend "azurerm" {
    resource_group_name  = "backend-rg"
    storage_account_name = "insidersstorageaccount"
    container_name       = "insidercontainer"
    key                  = "todoinfra.tfstate"
  }

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.57.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "ae541482-2a9e-4a6d-a4f0-1618f02c5bbf"
  }
