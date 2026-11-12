terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.17.0"
}

provider "yandex" {
  # token                    = "do not use!!!"
  cloud_id                 = "b1g5h3umi9k7s183tqam"
  folder_id                = "b1gaiajae68am1nfn312"
  service_account_key_file = file("~/authorized_key.json")
  zone                     = "ru-central1-a"
}
