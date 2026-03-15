resource "unifi_client" "apple_tv_bedroom" {
  mac    = "c4:f7:c1:0e:88:e3"
  name   = "Apple TV - Bedroom"
  groups = ["Media"]
}

resource "unifi_client" "bedroom_tv" {
  mac    = "4c:ba:d7:e0:11:54"
  name   = "Bedroom TV"
  groups = ["Media"]
}

resource "unifi_client" "google_home_bedroom" {
  mac    = "54:60:09:6f:21:60"
  name   = "Google Home - Master Bedroom"
  groups = ["Media"]
}

resource "unifi_client" "google_home_office" {
  mac    = "30:fd:38:73:41:e7"
  name   = "Google Home Mini - Office"
  groups = ["Media"]
}

resource "unifi_client" "roku_express" {
  mac    = "d8:31:34:22:4d:eb"
  name   = "Roku Express"
  groups = ["Media"]
}

resource "unifi_client" "google_nest_hub" {
  mac    = "14:c1:4e:26:81:91"
  groups = ["Media"]
}