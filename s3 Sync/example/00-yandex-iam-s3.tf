resource "yandex_iam_service_account" "s3_sync_sa" {
  name        = "s3-sync-sa"
  description = "service account to sync s3"
}



resource "yandex_resourcemanager_folder_iam_member" "sa_admin" {
  folder_id = var.folder_id

  role   = "editor"
  member = "serviceAccount:${yandex_iam_service_account.s3_sync_sa.id}"
}


resource "yandex_iam_service_account_static_access_key" "sa_static_key" {
  service_account_id = yandex_iam_service_account.s3_sync_sa.id
  description        = "static access key for object storage"
}

resource "random_string" "project_suffix" {
  length = 10
  upper   = false
  lower   = true
  number  = true
  special = false
}

resource "yandex_storage_bucket" "aws_yc_sync" {
  bucket = "yc-s3-sync-${random_string.project_suffix.result}"
  access_key = yandex_iam_service_account_static_access_key.sa_static_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa_static_key.secret_key
  acl    = "private"

}