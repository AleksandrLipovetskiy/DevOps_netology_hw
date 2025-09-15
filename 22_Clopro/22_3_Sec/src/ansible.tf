locals {
  ansible_user             = "ubuntu"
  ansible_private_key_file = "/home/sam/.ssh/id_ed25519"
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tftpl", {
    web_vms = [
      for vm in yandex_compute_instance.web : {
        name              = vm.name
        network_interface = vm.network_interface
        fqdn              = "${vm.name}.${var.vpc_name}.internal"
      }
    ]
    back_vms = [
      for vm in yandex_compute_instance.back : {
        name              = vm.name
        network_interface = vm.network_interface
        fqdn              = "${vm.name}.${var.vpc_name}.internal"
      }
    ]
    nat_vm = {
      name              = yandex_compute_instance.nat_instance.name
      network_interface = yandex_compute_instance.nat_instance.network_interface[0]
      fqdn              = "${yandex_compute_instance.nat_instance.name}.${var.vpc_name}.internal"
    }

    ansible_user             = local.ansible_user
    ansible_private_key_file = local.ansible_private_key_file
  })
  
  filename = "${path.module}/prod.yml"
}
