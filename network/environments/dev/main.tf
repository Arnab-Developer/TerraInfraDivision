terraform {
  required_version = "1.11.1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.24.0"
    }
  }

  backend "local" {
    path = "C:/tf_states/terraapp1_network_dev.tfstate"
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id

  features {}
}

module "common" {
  source           = "../../modules/common"
  environment_name = "dev"
  address_space    = "10.0.0.0/16"
  application_name = var.application_name
}
