variable "cloud_id" {
  type        = string
}

variable "folder_id" {
  type        = string
}

#####################

# 1. Валидация одного IP-адреса
variable "ip_address" {
  type        = string
  description = "ip-адрес"
  default     = "192.168.0.1" #Для теста ошибки заменить на 1920.1680.0.1

  validation {
    condition     = can(cidrhost("${var.ip_address}/32", 0))
    error_message = "Неверный формат IPv4-адреса. Ожидается значение в формате X.X.X.X (от 0 до 255 в каждом октете)."
  }
}

# 2. Валидация списка IP-адресов
variable "ip_addresses_list" {
  type        = list(string)
  description = "список ip-адресов"
  default     = ["192.168.0.1", "1.1.1.1", "127.0.0.1"] # Для теста ошибки заменить на ["192.168.0.1", "1.1.1.1", "1270.0.0.1"]

  validation {
    # Функция alltrue проверяет, что условие истинно для КАЖДОГО элемента списка
    condition = alltrue([
      for ip in var.ip_addresses_list : can(cidrhost("${ip}/32", 0))
    ])
    error_message = "Один или несколько IP-адресов в списке имеют неверный формат."
  }
}