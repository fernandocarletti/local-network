# Authentication is handled via environment variables:
#   UNIFI_API_KEY  - API key for the controller
#   UNIFI_API      - Controller URL (https://192.168.1.1)
#   UNIFI_INSECURE - Skip TLS verification (self-signed cert)
#
# These are exported from .envrc

provider "unifi" {}
