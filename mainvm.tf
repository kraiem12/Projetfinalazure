

###################################################   VM jenkins   #########################################
#                                                                                                         #
#                                                                                                         #
#                                                                                                         #
###########################################################################################################
resource "azurerm_virtual_machine" "jenkins" {
  name                  = "${var.jenkinsName}"
  location              = "${azurerm_resource_group.GROUPE-cloud.location}"
  resource_group_name   = "${azurerm_resource_group.GROUPE-cloud.name}"
  network_interface_ids = ["${element(azurerm_network_interface.test.*.id,1)}"]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true


  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.5"
    version   = "latest"
  }
  storage_os_disk {

    name              = "myosdiskmetjenkins"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
   # ssh_keys {
  #    path     = "/home/testadmin/.ssh/authorized_keys"
  #    key_data = "${file("id_rsa.pub")}"
   # }

  }
  tags = {
    environment = "${var.jenkinsName}"
  }

}

#################################################    VM nexus        #########################################
#                                                                                                         #
#                                                                                                         #
#                                                                                                         #
###########################################################################################################

resource "azurerm_virtual_machine" "nexus" {
  name                  = "${var.nexusName}"
  location              = "${azurerm_resource_group.GROUPE-cloud.location}"
  resource_group_name   = "${azurerm_resource_group.GROUPE-cloud.name}"
  network_interface_ids = ["${element(azurerm_network_interface.test.*.id,2)}"]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true


  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.5"
    version   = "latest"
  }
  storage_os_disk {

    name              = "myosdiskmetnexus"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
    # ssh_keys {
    #    path     = "/home/testadmin/.ssh/authorized_keys"
    #    key_data = "${file("id_rsa.pub")}"
    # }

  }
  tags = {
    environment = "${var.nexusName}"
  }

}

##################################################        mv slave    #######################################
#                                                                                                         #
#                                                                                                         #
#                                                                                                         #
###########################################################################################################
resource "azurerm_virtual_machine" "slave" {
  name                  = "${var.slaveName}"
  location              = "${azurerm_resource_group.GROUPE-cloud.location}"
  resource_group_name   = "${azurerm_resource_group.GROUPE-cloud.name}"
  network_interface_ids = ["${element(azurerm_network_interface.test.*.id,3)}"]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true


  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.5"
    version   = "latest"
  }
  storage_os_disk {

    name              = "myosdiskmetslave"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
    # ssh_keys {
    #    path     = "/home/testadmin/.ssh/authorized_keys"
    #    key_data = "${file("id_rsa.pub")}"
    # }

  }
  tags = {
    environment = "${var.slaveName}"
  }

}
##################################################         Nginx    ######################################
#                                                                                                         #
#                                                                                                         #
#                                                                                                         #
###########################################################################################################
resource "azurerm_virtual_machine" "web" {
  name                  = "${var.Nginxname}"
  location              = "${azurerm_resource_group.GROUPE-cloud.location}"
  resource_group_name   = "${azurerm_resource_group.GROUPE-cloud.name}"
  network_interface_ids = ["${azurerm_network_interface.testPub.id}"]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true


  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.5"
    version   = "latest"
  }
  storage_os_disk {

    name              = "myosdiskmetweb"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
    # ssh_keys {
    #    path     = "/home/testadmin/.ssh/authorized_keys"
    #    key_data = "${file("id_rsa.pub")}"
    # }

  }
  tags = {
    environment = "${var.Nginxname}"
  }

}