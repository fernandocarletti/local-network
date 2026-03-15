resource "unifi_client" "lissa_iphone" {
  mac    = "a4:f9:21:b8:eb:5c"
  name   = "Lissa iPhone"
  groups = ["Lissa"]
}

resource "unifi_client" "lissa_ipad" {
  mac    = "50:57:8a:55:00:c9"
  groups = ["Lissa"]
}

resource "unifi_client" "lissa_macbook" {
  for_each = {
    wifi  = "2e:75:7d:37:c9:6b"
    wired = "80:69:1a:8c:92:f4"
  }

  mac    = each.value
  name   = "Lissa MacBook"
  groups = ["Lissa"]
}

resource "unifi_client" "lissa_kindle" {
  mac    = "20:a1:71:fe:0f:e1"
  name   = "Lissa Kindle"
  groups = ["Lissa"]
}
