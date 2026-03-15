locals {
  group_shared = "Shared"
}

resource "unifi_client" "epson_printer" {
  mac    = "e0:bb:9e:66:6d:d0"
  name   = "EPSON666DD0"
  groups = [local.group_shared]
}

resource "unifi_client" "asus_xt8" {
  mac      = "a0:36:bc:a1:0d:d0"
  name     = "Asus XT8"
  fixed_ip = "192.168.1.2"
  groups   = [local.group_shared]
}
