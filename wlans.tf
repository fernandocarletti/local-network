# Default AP group - required by unifi_wlan resources
data "unifi_ap_group" "default" {
  name = "All APs"
}

# Default user group (QoS rate) - required by unifi_wlan resources
data "unifi_client_qos_rate" "default" {
  name = "Default"
}

locals {
  ap_group_ids  = [data.unifi_ap_group.default.id]
  user_group_id = data.unifi_client_qos_rate.default.id
}

resource "unifi_wlan" "felis" {
  name          = "Felis"
  security      = "wpapsk"
  passphrase    = var.wlan_passphrase_felis
  network_id    = unifi_network.default.id
  ap_group_ids  = local.ap_group_ids
  user_group_id = local.user_group_id

  # Radio
  wlan_band  = "5g"
  wlan_bands = ["5g", "6g"]

  # Security
  wpa3_support    = true
  wpa3_transition = true
  pmf_mode        = "optional"

  # Features
  enabled              = true
  fast_roaming_enabled = true
  bss_transition       = true
  multicast_enhance    = true
  proxy_arp            = true
  hide_ssid            = false
  is_guest             = false
  l2_isolation         = false
  uapsd                = false
  no2ghz_oui           = false

  # Minimum data rates
  minimum_data_rate_2g_kbps  = 1000
  minimum_data_rate_5g_kbps  = 6000
  minrate_setting_preference = "auto"

  mac_filter = {
    enabled = false
    policy  = "deny"
  }
}

resource "unifi_wlan" "trizte" {
  name          = "Trizte"
  security      = "wpapsk"
  passphrase    = var.wlan_passphrase_trizte
  network_id    = unifi_network.default.id
  ap_group_ids  = local.ap_group_ids
  user_group_id = local.user_group_id

  # Radio
  wlan_band  = "2g"
  wlan_bands = ["2g"]

  # Security
  wpa3_support    = true
  wpa3_transition = true
  pmf_mode        = "optional"

  # Features
  enabled              = true
  fast_roaming_enabled = false
  bss_transition       = true
  multicast_enhance    = false
  proxy_arp            = false
  hide_ssid            = false
  is_guest             = false
  l2_isolation         = false
  uapsd                = false
  no2ghz_oui           = false

  # Minimum data rates
  minimum_data_rate_2g_kbps  = 1000
  minimum_data_rate_5g_kbps  = 6000
  minrate_setting_preference = "auto"

  mac_filter = {
    enabled = false
    policy  = "deny"
  }
}

resource "unifi_wlan" "cerio" {
  name          = "Cerio"
  security      = "wpapsk"
  passphrase    = var.wlan_passphrase_cerio
  network_id    = unifi_network.default.id
  ap_group_ids  = local.ap_group_ids
  user_group_id = local.user_group_id

  # Radio
  wlan_band  = "5g"
  wlan_bands = ["5g", "6g"]

  # Security
  wpa3_support    = true
  wpa3_transition = false
  pmf_mode        = "required"

  # Features
  enabled              = true
  fast_roaming_enabled = true
  bss_transition       = true
  multicast_enhance    = true
  proxy_arp            = true
  hide_ssid            = false
  is_guest             = false
  l2_isolation         = false
  uapsd                = true
  no2ghz_oui           = true

  # Minimum data rates
  minimum_data_rate_2g_kbps  = 1000
  minimum_data_rate_5g_kbps  = 6000
  minrate_setting_preference = "auto"

  mac_filter = {
    enabled = false
    policy  = "deny"
  }
}
