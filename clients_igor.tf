locals {
  group_igor = "Igor"
}

resource "unifi_client" "velvet" {
  mac    = "48:90:2f:da:33:b8"
  name   = "VELVET"
  groups = [local.group_igor]
}