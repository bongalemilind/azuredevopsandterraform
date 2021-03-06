provider "azurerm" {
  features {
    
  }
}

terraform {
  backend "azurerm" {
    resource_group_name = "tf_rg_blobstorage"
    storage_account_name = "tfstorageacc247"
    container_name = "tfstate"
    key = "terraform.tfstate"
  }  
}

variable "imagebuild" {
  type = string
  description = "Latest build iamge "
}


resource "azurerm_resource_group" "tf_test" {
  name = "tfmainrg"
  location = "East US"
}

resource "azurerm_container_group" "tfcg_test" {
  name = "weatherapi"
  location = azurerm_resource_group.tf_test.location
  resource_group_name  = azurerm_resource_group.tf_test.name

  ip_address_type = "Public" 
  dns_name_label = "mbtestapitf"
  os_type = "Linux"

  container {
    name = "weatherapi"
    image = "milindbongale/weatherapi:${var.imagebuild}"
    cpu = "1"
    memory = "1"

    ports {
      port = 80
      protocol = "TCP"
    }
  }
}
