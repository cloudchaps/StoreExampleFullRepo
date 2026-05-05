resource "azurerm_public_ip" "cloudchaps_store_public_ip" {
  name                = "${var.project_name}-${var.environment}-lb-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "cloudchaps_store_lb" {
  name                = "${var.project_name}-${var.environment}-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "public-frontend"
    public_ip_address_id = azurerm_public_ip.cloudchaps_store_public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "cloudchaps_store_address_pool" {
  name            = "${var.project_name}-${var.environment}-backend-pool"
  loadbalancer_id = azurerm_lb.cloudchaps_store_lb.id
}

resource "azurerm_lb_probe" "http_probe" {
  name            = "http-health-probe"
  loadbalancer_id = azurerm_lb.cloudchaps_store_lb.id
  protocol        = "Http"
  port            = 80
  request_path    = "/"
}

resource "azurerm_lb_rule" "http_rule" {
  name                           = "http-rule"
  loadbalancer_id                = azurerm_lb.cloudchaps_store_lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "public-frontend"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.cloudchaps_store_address_pool.id]
  probe_id                       = azurerm_lb_probe.http_probe.id
}

resource "azurerm_network_interface" "cloudchaps_store_network_interface" {
  count = var.vm_count

  name                = "${var.project_name}-${var.environment}-vm-${count.index + 1}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.public_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "cloudchaps_store_address_pool_association" {
  count = var.vm_count

  network_interface_id    = azurerm_network_interface.cloudchaps_store_network_interface[count.index].id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.cloudchaps_store_address_pool.id
}

resource "azurerm_linux_virtual_machine" "cloudchaps_store_vms" {
  count = var.vm_count

  name                = "${var.project_name}-${var.environment}-vm-${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.cloudchaps_store_network_interface[count.index].id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = base64encode(templatefile("${path.module}/cloud-init.sh", {
    hostname = "${var.project_name}-${var.environment}-vm-${count.index + 1}"
  }))
}