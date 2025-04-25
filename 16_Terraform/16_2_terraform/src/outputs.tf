output "platform_details" {
  description = "Сведения о платформе прилодения"
  value = {
    instance_name = yandex_compute_instance.platform.name
    external_ip   = yandex_compute_instance.platform.network_interface[0].nat_ip_address
    fqdn          = "${yandex_compute_instance.platform.name}.example.com"
  }
}

output "db_details" {
  description = "Сведения о платформе БД"
  value = {
    instance_name = yandex_compute_instance.db.name
    external_ip   = yandex_compute_instance.db.network_interface[0].nat_ip_address
    fqdn          = "${yandex_compute_instance.db.name}.example.com"
  }
}