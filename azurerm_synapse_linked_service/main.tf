resource "azurerm_synapse_linked_service" "this" {
  name                 = "example"
  synapse_workspace_id = azurerm_synapse_workspace.example.id
  type                 = "AzureBlobStorage"
  type_properties_json = var.type_properties_json

additional_properties = var.additional_properties
annotations = var.annotations
description = var.description

dynamic "integration_runtime" {
    for_each = var.integration_runtime
    content {
      name = integration_runtime.value["name"]
      parameters = integration_runtime.value["parameters"]
    }
  }

parameters = var.parameters
}
