locals {
  group_kaio = "Kaio"
}

resource "unifi_client" "kaio_g15" {
  mac    = "f0:d4:15:78:b0:72"
  name   = "Kaio_G15"
  groups = [local.group_kaio]
}