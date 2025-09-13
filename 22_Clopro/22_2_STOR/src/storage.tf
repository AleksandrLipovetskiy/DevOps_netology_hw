resource "yandex_storage_bucket" "student_bucket" {
  bucket        = var.storage_settings.bucket
  folder_id     = var.folder_id
  force_destroy = var.storage_settings.force_destroy

  anonymous_access_flags {
    read = var.storage_settings.read
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
