variable "network_name" {
  type        = string
  description = "Название виртуальной сети"
}

variable "subnet_name" {
  type        = string
  description = "Название подсети"
}

variable "zone" {
  type        = string
  description = "Зона доступности подсети (например, ru-central1-a)"
}

variable "v4_cidr_blocks" {
  type        = list(string)
  description = "Диапазон CIDR-блоков для подсети"
}
