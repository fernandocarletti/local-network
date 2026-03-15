# AGENTS.md

## Project Overview

OpenTofu infrastructure-as-code for a UniFi home network. Manages networks,
VLANs, WLANs, site settings, and client device assignments via the
`ubiquiti-community/unifi` Terraform provider (v0.41.25). State is local
(no remote backend). The controller runs on a UDM at `https://192.168.1.1`.

## Prerequisites

- **OpenTofu >= 1.6** (`tofu` CLI, not `terraform`).
- **Always `source .envrc`** before running any `tofu` command. direnv is
  not auto-loaded in agent shells. This file exports `UNIFI_API_KEY`,
  `UNIFI_API`, `UNIFI_INSECURE`, and `TF_VAR_*` variables.
- Run `tofu init` if `.terraform/` is missing.

## Commands

```bash
source .envrc              # REQUIRED before every tofu command
tofu plan                  # Preview changes (always run first)
tofu apply                 # Apply changes (prefer -auto-approve only when plan was reviewed)
tofu apply -refresh-only   # Sync state with controller without changing infra
tofu validate              # Check syntax and configuration validity
tofu fmt -check            # Check formatting (2-space indent, aligned =)
tofu fmt                   # Auto-format all .tf files
tofu state list            # List all managed resources
tofu state show <addr>     # Inspect a single resource in state
tofu import <addr> <id>    # Import existing controller object into state
tofu state mv <old> <new>  # Rename a resource address in state
```

There are no tests, linters, CI pipelines, or Makefiles in this project.
Validation is done by running `tofu plan` and confirming zero unexpected diff.

## Provider Bugs & Workarounds

The `ubiquiti-community/unifi` provider has known bugs. Follow these rules:

1. **Plugin crashes**: The provider randomly crashes with "Plugin did not
   respond". Retry after a ~5 second delay. This is transient.

2. **Never let the provider Create a client**: The `allow_existing` Create
   path has a bug that drops planned values (name, groups, network_id).
   **Always `tofu import` first, then `tofu apply`** for existing clients.

3. **`vlan_enabled` on Default network**: The provider always sends
   `vlan_enabled: true` when updating the Default network, but the API
   rejects it. Make Default network changes via direct API calls (`curl`),
   then `tofu apply -refresh-only` to sync state.

4. **`fixed_ip` + VNO conflict**: When adding `network_id` (VNO) to move a
   client to a different VLAN, the plan inherits the old `fixed_ip` from
   state. Clear it via API first:
   ```bash
   curl -sk -X PUT -H "X-API-KEY: $UNIFI_API_KEY" \
     -H "Content-Type: application/json" \
     "https://192.168.1.1/proxy/network/api/s/default/rest/user/<client_id>" \
     -d '{"use_fixedip": false, "fixed_ip": ""}'
   ```
   Then `tofu apply -refresh-only`, then `tofu apply`.

5. **`skip_forget_on_destroy`**: This attribute is not preserved after
   updates due to a provider bug. Do not set it. Avoid `tofu destroy` on
   client resources.

6. **Inconsistent result after network create**: New networks may get
   controller-overridden defaults (e.g., `multicast_dns`, `igmp_snooping`).
   Set config values to match what the controller returns, then
   `tofu untaint` if needed.

## File Organization

| File pattern          | Contents                                    |
|-----------------------|---------------------------------------------|
| `versions.tf`         | `terraform` block with required providers   |
| `provider.tf`         | Provider configuration (empty block)        |
| `variables.tf`        | Input variable declarations                 |
| `settings.tf`         | `unifi_setting` resource                    |
| `networks.tf`         | `unifi_network` resources                   |
| `wlans.tf`            | `unifi_wlan` resources                      |
| `clients_<group>.tf`  | Client devices grouped by owner/category    |

No modules, no `main.tf`, no `outputs.tf`. Resources are split by domain.
Data sources live next to the resources that reference them.

## Code Style

### Formatting
- **2-space indentation**, no tabs.
- **Align `=` signs** within each logical section of a resource block.
- **One blank line** between top-level blocks.
- **One blank line** before each `# Section` comment inside a resource.
- **No blank line** after opening `{` or before closing `}`.
- **No trailing blank line** at end of file.

### Comments
- Use `#` exclusively (no `//` or `/* */`).
- Section headers inside large resource blocks: `# Radio`, `# Security`, etc.
- Explanatory comments above blocks, not inline after attributes.

### Naming Conventions
- **Files**: lowercase, snake_case. Plural for collections (`networks.tf`,
  `wlans.tf`). Client files use `clients_<group>.tf`.
- **Resources**: snake_case, descriptive. Match the real-world name or
  purpose (e.g., `unifi_wlan.felis`, `unifi_client.ac_office`).
- **Data sources**: use `default` as the logical name when there's one
  canonical instance (e.g., `data.unifi_ap_group.default`).
- **Variables**: snake_case, prefixed by resource type
  (`wlan_passphrase_felis`).

### Attribute Order in Resources
1. Identity attributes: `mac`, `name`, `security`, `passphrase`
2. Relationship references: `network_id`, `ap_group_ids`, `groups`
3. Configuration flags, grouped by `# Section` comment headers
4. Nested blocks last

### Client Resources (`unifi_client`)
Attribute order: `mac`, `name` (only if controller has one), `fixed_ip`
(only if DHCP reservation exists), `groups`, `network_id` (only for VNO).

### Variables
```hcl
variable "example" {
  description = "What this variable is for"
  type        = string
  sensitive   = true
}
```
Order: `description`, `type`, `sensitive`. Align `=` signs.

### `for_each`
Use inline maps when iterating over a small set (e.g., multiple MACs for
the same device). Align `=` signs in the map. Use descriptive keys.
```hcl
resource "unifi_client" "lissa_macbook" {
  for_each = {
    wifi  = "b6:37:67:c7:a4:8b"
    wired = "80:69:1a:8c:92:f4"
    wifi2 = "2e:75:7d:37:c9:6b"
  }
  mac    = each.value
  name   = "Lissa MacBook"
  groups = ["Lissa"]
}
```

## Secrets

- All secrets live in `.envrc` (gitignored) using `export`.
- WiFi passphrases use `TF_VAR_wlan_passphrase_<ssid>` convention.
- API key uses `UNIFI_API_KEY` (provider env var, not `TF_VAR_`).
- Never commit `.envrc`, `*.tfvars`, or any file containing secrets.
- Always mark secret variables with `sensitive = true`.

## Direct API Access

The controller API is at `https://192.168.1.1/proxy/network/`. Authenticate
with `X-API-KEY: $UNIFI_API_KEY`. Use `-sk` for self-signed cert. Common
endpoints:
- `api/s/default/rest/user/<id>` -- client devices (GET/PUT)
- `v2/api/site/default/network-members-groups` -- client groups/tags
- `api/s/default/rest/networkconf/<id>` -- network configuration
