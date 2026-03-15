locals {
  group_iot = "IoT"
}

resource "unifi_client" "ac_office" {
  mac        = "44:27:45:dc:fb:ee"
  name       = "Air Conditioner - Office"
  groups     = [local.group_iot]
  network_id = unifi_network.iot.id
}

resource "unifi_client" "nest_cam" {
  mac        = "18:b4:30:61:94:3b"
  name       = "Nest Cam Indoor"
  groups     = [local.group_iot]
  network_id = unifi_network.iot.id
}

resource "unifi_client" "hue_bridge" {
  mac        = "00:17:88:28:af:fa"
  name       = "Philips Hue Bridge"
  fixed_ip   = "192.168.10.200"
  groups     = [local.group_iot]
  network_id = unifi_network.iot.id
}

resource "unifi_client" "roomba" {
  mac        = "4c:b9:ea:35:a3:5a"
  name       = "Roomba"
  groups     = [local.group_iot]
  network_id = unifi_network.iot.id
}

resource "unifi_client" "nokia_scale" {
  mac        = "00:24:e4:7e:28:32"
  name       = "Nokia Body Scale"
  groups     = [local.group_iot]
  network_id = unifi_network.iot.id
}
