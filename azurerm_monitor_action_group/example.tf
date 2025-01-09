module "ag" {
  source = "../module/action_group"

  name = "myactiongroup"
  resource_group_name = "myrg"
  short_name = "azAG"
  email_receiver = [
  {
      name                    = "user name"
      email_address           = "abc@example.com"
      use_common_alert_schema = true
  }
  ]

}
