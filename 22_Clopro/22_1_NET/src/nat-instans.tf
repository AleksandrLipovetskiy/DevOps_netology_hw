resource "yandex_compute_instance" "nat_instance" {
  name        = "nat_instance"
  platform_id = var.instance_settings.platform_id
  zone        = var.default_zone

  resources {
    cores         = var.instance_settings.core_count
    memory        = var.instance_settings.memory_count
    core_fraction = var.instance_settings.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.nat_instans.image_id
      size     = var.instance_settings.hdd_size
      type     = var.instance_settings.hdd_type
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    nat                = var.instance_settings.nat
    ip_address         = "192.168.10.254"
    #security_group_ids = [yandex_vpc_security_group.example.id]
  }

  scheduling_policy {
    preemptible = var.instance_settings.preemptible
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
    user-data = <<-EOF
      #cloud-config
      runcmd:
        - sysctl -w net.ipv4.ip_forward=1
        - iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
        - iptables-save > /etc/iptables.rules
        - bash -c 'echo -e "#!/bin/sh\niptables-restore < /etc/iptables.rules" > /etc/network/if-pre-up.d/iptables'
        - chmod +x /etc/network/if-pre-up.d/iptables
    EOF
  }
}