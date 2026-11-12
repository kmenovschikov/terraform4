output "network_id" {
  description = "ID созданной виртуальной сети"
  value       = yandex_vpc_network.network.id # Извлекаем ID ресурса сети
}

output "subnet" {
  description = "Полный объект созданной подсети со всеми атрибутами"
  value       = yandex_vpc_subnet.subnet
}

output "zone" {
  description = "Зона доступности, в которой создана подсеть"
  value       = yandex_vpc_subnet.subnet.zone # Извлекаем зону из созданного ресурса подсети
}