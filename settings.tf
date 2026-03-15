resource "unifi_setting" "default" {
  site = "default"
}

# Missing in the provider:
# - DNS over HTTPS (DoH)
