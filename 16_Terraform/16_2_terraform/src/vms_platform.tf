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




