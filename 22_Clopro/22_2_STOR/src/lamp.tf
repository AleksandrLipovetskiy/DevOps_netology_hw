resource "yandex_compute_instance_group" "lamp_group" {
  name               = var.instance_group_name
  folder_id          = var.folder_id
  service_account_id = var.service_account_id
  
  instance_template {
    platform_id = var.instance_settings.platform_id
    resources {
      cores  = var.instance_settings.core_count
      memory = var.instance_settings.memory_count
    }

    boot_disk {
      initialize_params {
        image_id = data.yandex_compute_image.lamp.image_id
      }
    }

    network_interface {
      subnet_ids = [yandex_vpc_subnet.public.id]
      nat        = var.instance_settings.nat
    }

    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}",
      user-data = templatefile(var.storage_settings.config_path, {
        student_name   = var.storage_settings.student_name,
        date           = var.storage_settings.date,
        img_name       = var.storage_settings.img_name,
        ssh_user       = var.ssh_user,
        ssh_public_key = file(var.ssh_public_key),
      })
    }
  }

  scale_policy {
    fixed_scale {
      size = var.instance_count
    }
  }

  deploy_policy {
    max_unavailable = var.deploy_settings.deploy_max_unavailable
    max_creating    = var.deploy_settings.deploy_max_creating
    max_expansion   = var.deploy_settings.deploy_max_expansion
    max_deleting    = var.deploy_settings.deploy_max_deleting
  }

  allocation_policy {
    zones = [var.default_zone]
  }

  health_check {
    http_options {
      port = var.health_check.port
      path = var.health_check.path
    }
    interval            = var.health_check.interval
    timeout             = var.health_check.timeout
    healthy_threshold   = var.health_check.healthy_threshold
    unhealthy_threshold = var.health_check.unhealthy_threshold
  }
}
