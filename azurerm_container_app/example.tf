module "capp" {
  source = "../azurerm_container_app"

  name = ""
  resource_group_name = ""

  container_app_environment_id = ""

  template = [ {
    container = [ {
      args = []
      image = ""
    } ]
  } ]

  ingress = [{
    target_port = 80
    exposed_port = 80
  }]

identity = [ {
  type = "SystemAssigned"
} ]

}