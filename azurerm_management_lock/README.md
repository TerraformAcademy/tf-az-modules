### How to Use

```hcl 
module "lock" {
    source       = "../../azurerm_management_lock"
    name         = "database-lock"
    scope        = module.db.id
    lock_level   = "CanNotDelete"
}


```