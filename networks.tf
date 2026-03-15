resource "unifi_network" "default" {
  name               = "Default"
  subnet             = "192.168.1.1/24"
  domain_name        = "localdomain"
  enabled            = true
  gateway_type       = "default"
  setting_preference = "manual"

  # DHCP
  dhcp_server = {
    enabled             = true
    start               = "192.168.1.6"
    stop                = "192.168.1.254"
    leasetime           = 86400
    conflict_checking   = true
    dns_enabled         = false
    ntp_enabled         = false
    gateway_enabled     = false
    time_offset_enabled = false
    boot = {
      enabled = false
      server  = ""
    }
    wins = {
      enabled = false
    }
  }

  # Features
  auto_scale        = false
  igmp_snooping     = true
  internet_access   = true
  multicast_dns     = true
  lte_lan           = true
  network_isolation = false

  # IPv6
  ipv6_interface_type = "none"
}

resource "unifi_network" "iot" {
  name    = "IoT"
  subnet  = "192.168.10.1/24"
  vlan    = 2
  enabled = true

  # DHCP
  dhcp_server = {
    enabled             = true
    start               = "192.168.10.6"
    stop                = "192.168.10.254"
    leasetime           = 86400
    conflict_checking   = true
    dns_enabled         = false
    ntp_enabled         = false
    gateway_enabled     = false
    time_offset_enabled = false
    boot = {
      enabled = false
    }
    wins = {
      enabled = false
    }
  }

  # Features
  igmp_snooping     = false
  internet_access   = true
  multicast_dns     = true
  network_isolation = true

  # IPv6
  ipv6_interface_type = "none"
}
