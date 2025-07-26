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
    mon_vms = {
      name = yandex_compute_instance.mon.name
      network_interface = yandex_compute_instance.mon.network_interface
      fqdn = "${yandex_compute_instance.mon.name}.${var.vpc_name}.internal"
    }
  })
  filename = "${path.module}/inventory.yml"
}