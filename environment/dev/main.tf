module "rg"{
    source = "../../modules/resource_group"
    rgs = var.rg
}
module "vnet"{
    source = "../../modules/virtual_network"
    vnets = var.vnet
    depends_on = [ module.rg ]
}
module "subnet"{
    source = "../../modules/subnet"
    subnets = var.subnet
    depends_on = [ module.vnet ]
}
module "pip"{
    source = "../../modules/public _ip"
    pips = var.pip
    depends_on = [ module.rg ]
}
module "keyvault"{
    source = "../../modules/azure_keyvault"
    keyvaults = var.keyvault
    depends_on = [ module.rg ]
}
module "vm" {
  source = "../../modules/virtual_machine"
  vms = var.vm
  depends_on = [ module.subnet , module.pip , module.keyvault ]
}