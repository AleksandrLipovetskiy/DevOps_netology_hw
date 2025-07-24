###cloud vars
variable "token" {
  type        = string
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

data "yandex_compute_image" "centos-7" {
  family = "centos-7"
  image  = "fd8nsmhrlgp168q6h6aa"
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

variable "vm_count" {
  type    = number
  default = 3
}

variable "vm_prefix" {
  type    = string
  default = "vm-sam"
}

variable "subnet_name" {
  type    = string
  default = "my-subnet"
}

variable "vpc_name" {
  type    = string
  default = "my-vpc"
}

variable "image_family" {
  type    = string
  default = "ubuntu-2004-lts" # Используйте актуальную версию Ubuntu
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to the SSH public key"
  default     = "~/.ssh/id_rsa.pub" # Default path, change if needed
}

variable "ssh_private_key_path" {
  type        = string
  description = "Path to the SSH private key for Ansible"
  default     = "~/.ssh/id_rsa" # Default path, change if needed
}

# Read the SSH public key from the file
data "local_file" "ssh_public_key" {
  filename = var.ssh_public_key_path
}

# Define hostnames for each VM
variable "hostnames" {
  type    = list(string)
  default = ["clickhouse", "vector", "lighthouse"]
}