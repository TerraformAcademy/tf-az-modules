terraform {

}

provider "azurerm" {
  features {

  }
}

# data "azurerm_management_group" "this" {
#   name = "root1"
# }

# output "mg" {
#   value = data.azurerm_management_group.this.all_management_group_ids
# }

# locals {
#   mg = split("/", data.azurerm_management_group.this.all_management_group_ids[0])
#   mg_name = element(local.mg, 4)
#   env = element(split("/", data.azurerm_management_group.this.all_management_group_ids[0]), 4)
#   envs = split("-", element(split("/", data.azurerm_management_group.this.all_management_group_ids[0]), 4))
#   env1 = "${element(split("-", element(split("/", data.azurerm_management_group.this.all_management_group_ids[0]), 4)), 3)}"
# }

data "azurerm_storage_blob" "this" {
  name                   = "blob.txt"
  storage_account_name   = "kotnalaa"
  storage_container_name = "test"
}
# 101268589596