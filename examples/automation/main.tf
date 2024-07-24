module "auto" {
  source = "../../azurerm_automation_account"

  name = "myautoaccount"
  location = "eastus2"
  resource_group_name = "my-rg"
  sku_name = "Standard"

  runbook = {
    "run1" = {
        name = "runbook1"
        runbook_type = "PowerShell"
        log_progress = "true"
        log_verbose = "true"

        publish_content_link = [{
          uri = null
        }]

        content = "script"

        job_schedule = [{
          schedule_name = "myschedule1"
          parameters = {}
        }]
    }
  }

  schedule = {
    "schedule1" = {
        name = "schedule1"
        frequency = "Week"
        interval = 1

    } 
  }
}