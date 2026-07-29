data "azurerm_subnet" "this" {
    for_each = var.vms
    name = each.value.subnet_name
    resource_group_name = each.value.rg_name
    virtual_network_name = each.value.vnet_name
}
data "azurerm_public_ip" "this"{
    for_each = var.vms
    name = each.value.pip_name
    resource_group_name = each.value.rg_name
}

data "azurerm_key_vault" "this" {
    for_each = var.vms
    name = each.value.keyvault_name
    resource_group_name = each.value.rg_name
}

data "azurerm_key_vault_secret" "username"{
    for_each = var.vms
    name = each.value.username
    key_vault_id = data.azurerm_key_vault.this[each.key].id
}

data "azurerm_key_vault_secret" "password"{
    for_each = var.vms
    name = each.value.passname
    key_vault_id = data.azurerm_key_vault.this[each.key].id
}

resource "azurerm_network_interface" "this"{
    for_each = var.vms
    name = each.value.nic_name
    resource_group_name = each.value.rg_name
    location = each.value.location
    ip_configuration {
      name = "internal"
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id = data.azurerm_public_ip.this[each.key].id
      subnet_id = data.azurerm_subnet.this[each.key].id
    }
}
resource "azurerm_linux_virtual_machine" "this"{
    for_each = var.vms
    name = each.value.vm_name
    location = each.value.location
    resource_group_name = each.value.rg_name
    size = each.value.vm_size
    network_interface_ids = [azurerm_network_interface.this[each.key].id]
    admin_username = data.azurerm_key_vault_secret.username[each.key].value
    admin_password = data.azurerm_key_vault_secret.password[each.key].value
    disable_password_authentication = false
os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
}

  source_image_reference {
  publisher = "Canonical"
  offer     = "ubuntu-24_04-lts"
  sku        = "server"
  version    = "latest"
}
}
resource "azurerm_virtual_machine_extension" "install_nginx" {

for_each = var.vms
  name                 = "install-nginx"

  virtual_machine_id   = azurerm_linux_virtual_machine.this[each.key].id

  publisher            = "Microsoft.Azure.Extensions"

  type                 = "CustomScript"

  type_handler_version = "2.1"

  settings = <<SETTINGS
{
  "fileUris": [
    "https://anuraglocked.blob.core.windows.net/scripts/install-nginx.sh"
  ],

  "commandToExecute": "bash install-nginx.sh"
}
SETTINGS

}