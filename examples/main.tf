terraform {

}

provider "azurerm" {
  features {

  }
}

data "azurerm_storage_account" "this" {
  name                = "abcxyz"
  resource_group_name = "RG001"
}

data "azurerm_storage_blob" "this" {
  name                   = "backup.ps1"
  storage_account_name   = "abcxyz"
  storage_container_name = "test"
}

data "azurerm_storage_account_blob_container_sas" "this" {
  connection_string = data.azurerm_storage_account.this.primary_connection_string
  container_name    = "test"
  start             = timestamp()
  expiry            = timeadd(timestamp(), "15m")
  permissions {
    read   = true
    list   = true
    create = false
    write  = false
    delete = false
    add    = false
  }
}

data "azurerm_key_vault" "this" {
  name = "keyvault1"
  resource_group_name = "RSG01"  
}

data "azurerm_key_vault_secret" "password" {
  name = "sqlpassword"
  key_vault_id = data.azurerm_key_vault.this.id  
}

resource "azurerm_automation_runbook" "this" {
  name                    = "test"
  automation_account_name = "automation"
  location                = "eastus"
  resource_group_name     = "my-rsg-001"
  runbook_type            = "PowerShell"
  log_progress            = "true"
  log_verbose             = "true"
  publish_content_link {
    uri = "${data.azurerm_storage_blob.this.url}${data.azurerm_storage_account_blob_container_sas.this.sas}"
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
  schedule_name           = azurerm_automation_schedule.this.name
  runbook_name            = azurerm_automation_runbook.this.name
  parameters = {
    resource_group  = "rsg"
    storage_account = "strageajsdaiodu"
    password = data.azurerm_key_vault_secret.password.value# password from keyvault. 
  }
}

