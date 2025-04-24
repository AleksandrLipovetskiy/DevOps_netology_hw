###cloud vars


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
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_public_root_key" {
  type        = string
  description = "Public SSH key for VM access"
}


###Yandex compute image
variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Yandex compute image use OS"
}

###Yandex_compute_instance name
variable "vm_web_name_platform" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "yandex_compute_instance - name platform"
}

###Yandex_compute_instance platform_id
variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "yandex_compute_instance - platform_id"
}

###Yandex_compute OS user
variable "vm_web_user" {
  type        = string
  default     = "ubuntu"
  description = "yandex_compute_OS_user"
}
