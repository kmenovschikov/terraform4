/* resource "yandex_vpc_network" "develop" {
  name = "develop"
}

resource "yandex_vpc_subnet" "develop_a" {
  name           = "develop-ru-central1-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

resource "yandex_vpc_subnet" "develop_b" {
  name           = "develop-ru-central1-d"
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.2.0/24"]
} */

################################


module "vpc_dev" {
  source         = "./modules/my_vpc"
  network_name   = "develop-network"
  subnet_name    = "develop-subnet-a"
  zone           = "ru-central1-a"
  v4_cidr_blocks = ["10.0.1.0/24"]
}

module "marketing-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "develop" 
  network_id     = module.vpc_dev.network_id
  subnet_zones   = [module.vpc_dev.zone]
  subnet_ids     = [module.vpc_dev.subnet.id]
  instance_name  = "webs"
  instance_count = 1
  image_family   = "ubuntu-24-04-lts"
  public_ip      = true
  
  labels = { 
    project = "marketing"
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}

module "analytics-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "stage"
  network_id     = module.vpc_dev.network_id 
  subnet_zones   = [module.vpc_dev.zone]
  subnet_ids     = [module.vpc_dev.subnet.id]
  instance_name  = "web-stage"
  instance_count = 1
  image_family   = "ubuntu-24-04-lts"
  public_ip      = true

  labels = { 
    project = "analytics"
     }
  
  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}   

locals {
  ssh_key = file(pathexpand("~/.ssh/id_rsa.pub"))
}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  
    vars = {
      ssh_key = local.ssh_key 
  }
}

