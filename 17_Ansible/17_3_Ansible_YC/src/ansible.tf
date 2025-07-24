resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tftpl", {
    web_vms = [
      for vm in yandex_compute_instance.web : {
        name = vm.name
        network_interface = vm.network_interface
        fqdn = "${vm.name}.${var.vpc_name}.internal"
      }
    ]
    db_vms = [
      for vm in yandex_compute_instance.db : {
        name = vm.name
        network_interface = vm.network_interface
        fqdn = "${vm.name}.${var.vpc_name}.internal"
      }
    ]
    storage_vm = {
      name = yandex_compute_instance.storage.name
      network_interface = yandex_compute_instance.storage.network_interface
      fqdn = "${yandex_compute_instance.storage.name}.${var.vpc_name}.internal"
    }
  })
  filename = "${path.module}/inventory.yml"
}