data "azurerm_client_config" "current"{}

resource "azurerm_key_vault" "this"{
    for_each = var.keyvaults
    name = each.value.keyvault_name
    location = each.value.location
    resource_group_name = each.value.resource_group_name
    sku_name = "standard"
    tenant_id = data.azurerm_client_config.current.tenant_id
}

resource "azurerm_key_vault_access_policy" "terraform" {

  for_each = var.keyvaults

  key_vault_id = azurerm_key_vault.this[each.key].id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete"
  ]
}
resource "azurerm_key_vault_secret" "username"{
    for_each = var.keyvaults
    name = each.value.username
    value = each.value.admin_username
    key_vault_id = azurerm_key_vault.this[each.key].id
    depends_on = [azurerm_key_vault_access_policy.terraform]
}
resource "azurerm_key_vault_secret" "password"{
    for_each = var.keyvaults
    name = each.value.passname
    value = each.value.admin_password
    key_vault_id = azurerm_key_vault.this[each.key].id
    depends_on = [azurerm_key_vault_access_policy.terraform]
}