resource "yandex_compute_disk" "storage_disk" {
  count = 3

  name     = "${var.storage_disk.name}-${count.index + 1}"
  zone     = var.default_zone
  size     = var.storage_disk.size
  type     = var.storage_disk.type
}

resource "yandex_compute_instance" "storage" {
  name        = var.vm_storage_settings
  platform_id = var.instance_settings.platform_id
  zone        = var.default_zone

  resources {
    cores         = var.instance_settings.core_count
    memory        = var.instance_settings.memory_count
    core_fraction = var.instance_settings.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.instance_settings.hdd_size
      type     = var.instance_settings.hdd_type
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disk
    content {
      disk_id = secondary_disk.value.id
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.instance_settings.nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  scheduling_policy {
    preemptible = var.instance_settings.preemptible
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
}