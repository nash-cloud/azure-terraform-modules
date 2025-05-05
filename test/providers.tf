terraform {
  # backend "azurerm" {
  #   resource_group_name  = "rg-adl-terraform-state"
  #   storage_account_name = "stadlterraformstate"
  #   container_name       = "default"
  #   key                  = "datafactory.terraform.tfstate"
  # }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0" # "= 3.97.1"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}