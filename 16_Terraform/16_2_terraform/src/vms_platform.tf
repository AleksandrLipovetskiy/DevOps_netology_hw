variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  default = {
    platform = {
      cores         = 2
      memory        = 2
      core_fraction = 20
      hdd_size=10
      hdd_type="network-hdd"
    }
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
      hdd_size=10
      hdd_type="network-ssd"
    }
  }
  description = "Resources for VMs (platform and db)"
}

variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Версия операционной системы на машинах"
}

variable "vm_web_user" {
  type        = string
  default     = "ubuntu"
  description = "Пользователь операционной системы на виртуальных машинах"
}

variable "vm_web_name_platform" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Имя виртуальной машины приложения"
}

variable "vm_db_name_platform" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "Имя виртуальной машины базы данных"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Версия платформы виртуальной машины приложения"
}

variable "vms_metadata" {
  type        = map(string)
  default     = {
    "serial-port-enable" = "1"
    "ssh-keys"           = ""
  }
  description = "Metadata for all VMs"
}


