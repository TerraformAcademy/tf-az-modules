resource "azurerm_notification_hub_authorization_rule" "this" {
    name = var.name
    notification_hub_name = var.notification_hub_name
    namespace_name = var.namespace_name
    resource_group_name = var.resource_group_name
    manage = var.manage
    send = var.send
    listen = var.listen  
}