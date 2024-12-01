terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
    token = var.token
    folder_id = "b1guvuar0dp94ef9c9uo"
    zone = "ru-central1-a"
  
}