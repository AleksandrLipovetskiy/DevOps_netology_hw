resource "local_file" "ansible_inventory" {
  content = templatefile("${path}/inventory.j2", {
    clickhouse_ip   = yandex_compute_instance.clickhouse.network_interface.0.nat_ip_address
    vector_ip       = yandex_compute_instance.vector.network_interface.0.nat_ip_address
    lighthouse_ip   = yandex_compute_instance.lighthouse.network_interface.0.nat_ip_address
  })
  filename = "${path.module}/prod.yml"

  depends_on = [
    yandex_compute_instance.clickhouse,
    yandex_compute_instance.vector,
    yandex_compute_instance.lighthouse
  ]
}
