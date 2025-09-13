###cloud vars
variable "token" {
  type        = string
  sensitive   = true
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "service_account_id" {
  type        = string
  description = "service_account_id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "subnet_cidrs" {
  type = map(string)
  default = {
    public  = "192.168.10.0/24",
    private = "192.168.20.0/24"
  }
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2404-lts"
}

data "yandex_compute_image" "lamp" {
  image_id = "fd827b91d99psvq5fjit"
}

data "yandex_compute_image" "nat_instance" {
  image_id = "fd80mrhj8fl2oe87o4e1"
}

variable "instance_settings" {
  type = object({
    platform_id   = string,
    core_count    = number,
    core_fraction = number,
    memory_count  = number,
    hdd_size      = number,
    hdd_type      = string,
    preemptible   = bool,
    nat           = bool
  })
  default = {
    platform_id   = "standard-v3",
    core_count    = 4,
    core_fraction = 100,
    memory_count  = 4,
    hdd_size      = 20,
    hdd_type      = "network-hdd",
    preemptible   = true,
    nat           = true
  }
}

variable "storage_settings" {
  type = object({
    bucket         = string,
    force_destroy  = bool,
    read           = bool,
    source         = string,
    content_type   = string,
    config_path    = string,
    student_name   = string,
    date           = string,
    img_name       = string
  })
  default = {
    bucket         = "lipovetskiy20250911" 
    force_destroy  = true
    read           = true
    source         = "../pict.png"
    content_type   = "image/png"
    config_path    = "./config.yaml"
    student_name   = "Lipovetskiy" 
    date           = "20250911" 
    img_name       = "my_image.png"
  }
}

variable "instance_group_name" {
  type        = string
  default     = "lamp-instance-group"
  description = "Name of the instance group"
}

variable "instance_count" {
  type        = number
  default     = 3
  description = "Number of instances in the group"
}

variable "target_group_name" {
  type        = string
  default     = "lamp-target-group"
  description = "Name of the target group"
}

variable "load_balancer_name" {
  type        = string
  default     = "load-balancer"
  description = "Name of the load_balancer"
}

variable "deploy_settings" {
  type = object({
    deploy_max_unavailable = number,
    deploy_max_creating    = number,
    deploy_max_expansion   = number,
    deploy_max_deleting    = number
  })
  default = {
    deploy_max_unavailable = 1,
    deploy_max_creating    = 1,
    deploy_max_expansion   = 1,
    deploy_max_deleting    = 1
  }
}

variable "health_check" {
  type = object({
    port = number,
    path = string,
    interval            = number,
    timeout             = number,
    healthy_threshold   = number,
    unhealthy_threshold = number
  })
  default = {
    port = 80,
    path = "/",
    interval            = 5,
    timeout             = 3,
    healthy_threshold   = 2,
    unhealthy_threshold = 2
  }
}

variable "load_balancer" {
  type = object({
    name             = string,
    port             = number,
    target_port      = number,
    protocol         = string,
    healthcheck_name = string,
    healthcheck_port = number,
    healthcheck_path = string
  })
  default = {
    name                = "listener-http",
    port                = 80,
    target_port         = 80,
    protocol            = "tcp",
    healthcheck_name    = "http-check",
    healthcheck_port    = 80,
    healthcheck_path    = "/"
  }
}

variable "ssh_public_key" {
  default = "~/.ssh/id_ed25519.pub"
}

variable "ssh_user" {
  default = "ubuntu"
}
