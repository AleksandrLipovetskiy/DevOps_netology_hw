resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_network" "db" {
  name = var.vpc_db
}

resource "yandex_vpc_subnet" "develop_b" {
  name           = var.vpc_db
  zone           = var.b_zone
  network_id     = yandex_vpc_network.db.id
  v4_cidr_blocks = var.b_cidr
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image
}

resource "yandex_compute_instance" "platform" {
  name        = local.vm_web_name_all
  platform_id = var.vm_web_platform_id
  zone        = var.default_zone
  depends_on = [yandex_vpc_subnet.develop]
  allow_stopping_for_update = true
  resources {
    cores         = var.vms_resources["platform"].cores
    memory        = var.vms_resources["platform"].memory
    core_fraction = var.vms_resources["platform"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = merge(
    var.vms_metadata,
    {
      "ssh-keys" = "${var.vm_web_user}:${var.vms_ssh_public_root_key}"
    }
  )

}

resource "yandex_compute_instance" "db" {
  name        = local.vm_db_name_all
  platform_id = var.vm_web_platform_id
  zone        = var.b_zone
  depends_on = [yandex_vpc_subnet.develop_b]
  allow_stopping_for_update = true
  resources {
    cores         = var.vms_resources["db"].cores
    memory        = var.vms_resources["db"].memory
    core_fraction = var.vms_resources["db"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_b.id
    nat       = true
  }

  metadata = merge(
    var.vms_metadata,
    {
      "ssh-keys" = "${var.vm_web_user}:${var.vms_ssh_public_root_key}"
    }
  )
  
}