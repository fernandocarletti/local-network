resource "unifi_client" "xuru_phone" {
  mac    = "68:44:65:4e:24:33"
  groups = ["Fernando"]
}

resource "unifi_client" "fernando_pc_wifi" {
  mac      = "98:af:65:d3:8c:68"
  fixed_ip = "192.168.1.10"
  groups   = ["Fernando"]
}

resource "unifi_client" "syntage_macbook" {
  for_each = {
    wifi  = "82:6f:a6:54:50:3c"
    wifi2 = "84:2f:57:cc:8f:fb"
  }
  mac      = each.value
  name     = "Syntage MacBook"
  fixed_ip = each.key == "wifi" ? "192.168.1.12" : null
  groups   = ["Fernando"]
}

resource "unifi_client" "xuru_book" {
  mac      = "bc:d0:74:51:58:ac"
  fixed_ip = "192.168.1.11"
  groups   = ["Fernando"]
}

resource "unifi_client" "xuru_pad" {
  mac    = "70:72:fe:c5:b2:2f"
  groups = ["Fernando"]
}

resource "unifi_client" "fernando_pc_wired" {
  mac    = "b4:2e:99:aa:43:80"
  groups = ["Fernando"]
}

resource "unifi_client" "asus_xt8" {
  mac      = "a0:36:bc:a1:0d:d0"
  name     = "Asus XT8"
  fixed_ip = "192.168.1.2"
  groups   = ["Fernando"]
}

resource "unifi_client" "xurupi" {
  mac      = "dc:a6:32:c3:dc:9e"
  name     = "XuruPi"
  fixed_ip = "192.168.1.100"
  groups   = ["Fernando"]
}

resource "unifi_client" "carletti" {
  mac    = "f8:e4:3b:04:de:e7"
  name   = "Carletti"
  groups = ["Fernando"]
}

resource "unifi_client" "garmin" {
  mac    = "14:13:0b:d3:0d:a7"
  name   = "Garmin Forerunner 255 Music"
  groups = ["Fernando"]
}

resource "unifi_client" "xuru_kindle" {
  mac    = "dc:91:bf:99:64:32"
  name   = "XuruKindle"
  groups = ["Fernando"]
}