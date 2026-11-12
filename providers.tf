terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.17.0"
}

provider "yandex" {
  cloud_id                 = "var.cloud_id"
  folder_id                = "var.folder_id"
  service_account_key_file = file("~/authorized_key.json")
  zone                     = "ru-central1-a"
}
