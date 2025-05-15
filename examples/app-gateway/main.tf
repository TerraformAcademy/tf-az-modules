module "agw" {

  name = "my-agw"
  resource_group_name = "my-rg" 
  location = "eastus"

  backend_address_pool = [ {

     name = "bp-01"
     ip_addresses = ["10.0.0.1", "10.0.0.2"]
  }]

  backend_http_settings = [{
    cookie_based_affinity = false
    affinity_cookie_name = null
    name = "https-1"
    port = 443
    protocol = "https"
  }]

  frontend_ip_configuration = [{
    name = "fe-01"
    private_ip_address = "10.0.0.12"
    public_ip_address_id = module.public-ip.id
  }]

  frontend_port = [{
    name = "https"
    port = 443
  }]

}
