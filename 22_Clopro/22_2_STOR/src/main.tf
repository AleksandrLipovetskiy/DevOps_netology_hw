resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "public" {
  name           = "public"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = [var.subnet_cidrs["public"]]
}

resource "yandex_vpc_subnet" "private" {
  name           = "private"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = [var.subnet_cidrs["private"]]
  route_table_id = yandex_vpc_route_table.private_routes.id
}

resource "yandex_vpc_route_table" "private_routes" {
  name       = "private-routes"
  network_id = yandex_vpc_network.develop.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = yandex_compute_instance.nat_instance.network_interface[0].ip_address
  }
}

resource "yandex_lb_target_group" "lamp_target_group" {
  name = var.target_group_name

  dynamic "target" {
    for_each = yandex_compute_instance_group.lamp_group.instances
    content {
      address   = target.value.network_interface[0].ip_address
      subnet_id = yandex_vpc_subnet.public.id
    }
  }
}

resource "yandex_lb_network_load_balancer" "lb" {
  name = var.load_balancer_name

  listener {
    name        = var.load_balancer.name
    port        = var.load_balancer.port
    target_port = var.load_balancer.target_port
    protocol    = var.load_balancer.protocol
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.lamp_target_group.id

    healthcheck {
      name = var.load_balancer.healthcheck_name
      http_options {
        port = var.load_balancer.healthcheck_port
        path = var.load_balancer.healthcheck_path
      }
    }
  }
}
