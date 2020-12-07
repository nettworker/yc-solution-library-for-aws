#network



resource "yandex_vpc_network" "aws_k8s_vpc" {
  name      = "yc-subnet"
}

# public-subnet


resource "yandex_vpc_subnet" "aws_k8s_subnet" {
  name           = "yc-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.aws_k8s_vpc.id
  v4_cidr_blocks = [var.yandex_subnet_range]
}

