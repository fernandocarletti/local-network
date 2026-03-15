locals {
  group_ivone = "Ivone"
}

resource "unifi_client" "financeiro" {
  mac    = "88:f4:da:27:fd:3f"
  groups = [local.group_ivone]
}

resource "unifi_client" "a56_ivone" {
  for_each = {
    wifi  = "3e:58:e3:a0:10:33"
    wifi2 = "22:c6:74:72:19:10"
  }
  mac    = each.value
  name   = "A56-de-Ivone"
  groups = [local.group_ivone]
}

resource "unifi_client" "galaxy_ivone" {
  mac    = "6e:27:af:04:73:46"
  name   = "Galaxy-A30s-de-Ivone"
  groups = [local.group_ivone]
}

resource "unifi_client" "ivone_pc" {
  mac    = "64:32:a8:54:82:83"
  name   = "ivone-pc"
  groups = [local.group_ivone]
}
