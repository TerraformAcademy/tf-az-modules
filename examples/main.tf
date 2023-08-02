terraform {

}

provider "azurerm" {
  features {

  }
}

data "local_file" "this" {
  filename = "test.ps1"
}

resource "azurerm_automation_runbook" "this" {
  name                    = "test"
  automation_account_name = "automata"
  location                = "eastus"
  resource_group_name     = "my-rsg-007"
  runbook_type            = "PowerShell"
  log_progress            = "true"
  log_verbose             = "true"
  # content = data.local_file.this.content
  publish_content_link {
    uri = "https://kotnalaa.blob.core.windows.net/test/backup.ps1"
  }
}

resource "azurerm_automation_schedule" "this" {
  name                    = "auto-schedule"
  automation_account_name = "automata"
  resource_group_name     = "my-rsg-007"
  frequency               = "Day"
  interval                = 1
  start_time              = null
  timezone                = null
}

resource "azurerm_automation_job_schedule" "this" {
    automation_account_name = "automata"
  resource_group_name     = "my-rsg-007"
  schedule_name = azurerm_automation_schedule.this.name
  runbook_name = azurerm_automation_runbook.this.name
  parameters = {
    resource_group = "rsg"
    storage_account = "strageajsdaiodu"
  }
}