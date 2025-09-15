resource "yandex_kms_symmetric_key" "kms_key" {
  name               = "student-bucket-key"
  description        = "Key for bucket encryption"
  default_algorithm  = "AES_256"
  rotation_period    = "168h"
  deletion_protection = false
  #lifecycle {
    # prevent_destroy = true
  #}
}

resource "yandex_storage_bucket" "student_bucket" {
  bucket        = var.storage_settings.bucket
  folder_id     = var.folder_id
  force_destroy = var.storage_settings.force_destroy

  anonymous_access_flags {
    read = var.storage_settings.read
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.kms_key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "yandex_storage_object" "image_file" {
  bucket       = yandex_storage_bucket.student_bucket.bucket
  key          = var.storage_settings.img_name
  source       = var.storage_settings.source
  content_type = var.storage_settings.content_type
}

output "public_url" {
  value = "https://storage.yandexcloud.net/${yandex_storage_bucket.student_bucket.bucket}/${yandex_storage_object.image_file.key}"
}
