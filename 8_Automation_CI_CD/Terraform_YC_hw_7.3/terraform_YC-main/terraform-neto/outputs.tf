output "external_ipv4_address" {
    value = yandex_vpc_address.sam-network.external_ipv4_address[0].address
}