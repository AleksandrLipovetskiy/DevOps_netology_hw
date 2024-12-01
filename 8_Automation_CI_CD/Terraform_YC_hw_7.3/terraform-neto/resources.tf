resource "yandex_compute_disk" "sam-disk" {
    name = "sam-disk"
    size = 10
    image_id = "fd8gqkbp69nel2ibb5pr"
    labels = {
        "structure" = "sam-netology"
    }
  }

resource "yandex_vpc_address" "sam-network" {
  name = "sam-network"
  external_ipv4_address {
    zone_id = "ru-central1-a"
  }
}

resource "yandex_compute_instance" "sam-cpu" {
    name = "sam-cpu"
    zone = "ru-central1-a"
    resources {
      cores = 2
      memory = 2
    }

    boot_disk {
     disk_id = yandex_compute_disk.sam-disk.id 
    }

    network_interface {
      subnet_id = "e9bk4g9i9mpvr2jdtvbu"
      nat = true
      nat_ip_address = yandex_vpc_address.sam-network.external_ipv4_address[0].address
    }

    metadata = {
      user-data = "${file("user-data.yaml")}" 
    }
  }