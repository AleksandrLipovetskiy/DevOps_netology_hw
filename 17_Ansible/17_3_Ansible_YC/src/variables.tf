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

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2404-lts"
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
    core_count    = 2,
    core_fraction = 20,
    memory_count  = 4,
    hdd_size      = 10,
    hdd_type      = "network-hdd",
    preemptible   = true,
    nat           = true
  }
}

variable "each_db" {
  type = list(object({
    vm_name       = string
    cpu           = number
    ram           = number
    disk_volume   = number
    core_fraction = number
    platform_id   = string
    disk_type     = string
    preemptible   = bool
    nat           = bool
    zone          = string
  }))
  default = [
    {
      vm_name       = "main"
      cpu           = 4
      ram           = 4
      disk_volume   = 15
      core_fraction = 50
      platform_id   = "standard-v3"
      disk_type     = "network-ssd"
      preemptible   = false
      nat           = true
      zone          = "ru-central1-a"
    },
    {
      vm_name       = "replica"
      cpu           = 2
      ram           = 4
      disk_volume   = 10
      core_fraction = 20
      platform_id   = "standard-v3"
      disk_type     = "network-hdd"
      preemptible   = true
      nat           = true
      zone          = "ru-central1-a"
    }
  ]
  description = "Settings for database VMs (main and replica)"
}
