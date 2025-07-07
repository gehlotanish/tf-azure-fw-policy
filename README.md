# template-terraform
Template repository for all terraform module repositories

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.27.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.35.0 |
## Modules

No modules.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_explicit_proxy"></a> [explicit\_proxy](#input\_explicit\_proxy) | Explicit proxy configuration. | `any` | `null` | no |
| <a name="input_firewall_policy_dns"></a> [firewall\_policy\_dns](#input\_firewall\_policy\_dns) | DNS settings block for the Firewall Policy. | `any` | `null` | no |
| <a name="input_firewall_policy_name"></a> [firewall\_policy\_name](#input\_firewall\_policy\_name) | Name for the Azure Firewall Policy. | `string` | n/a | yes |
| <a name="input_firewall_policy_sku"></a> [firewall\_policy\_sku](#input\_firewall\_policy\_sku) | SKU tier for the Azure Firewall Policy. | `string` | `"Standard"` | no |
| <a name="input_intrusion_detection"></a> [intrusion\_detection](#input\_intrusion\_detection) | Intrusion detection configuration for the Firewall Policy. | `any` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region for resource deployment. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group where resources will be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to resources. | `map(string)` | `{}` | no |
| <a name="input_threat_intelligence_allowlist"></a> [threat\_intelligence\_allowlist](#input\_threat\_intelligence\_allowlist) | Threat intelligence allowlist configuration. | `any` | `null` | no |
| <a name="input_threat_intelligence_mode"></a> [threat\_intelligence\_mode](#input\_threat\_intelligence\_mode) | Threat intelligence mode for the Firewall Policy. | `string` | `"Alert"` | no |  
## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Usage

```
firewall_policy_name     = "my-fw-policy"
location                 = "eastus"
resource_group_name      = "my-rg"
firewall_policy_sku      = "Premium"  # or "Standard"
threat_intelligence_mode = "Alert"    # or "Deny", "Off"

firewall_policy_dns = {
  proxy_enabled = true
  servers       = ["8.8.8.8", "8.8.4.4"]
}

intrusion_detection = {
  mode           = "Alert"  # or "Deny", "Off"
  private_ranges = ["10.0.0.0/8", "192.168.0.0/16"]

  signature_overrides = [
    {
      id    = "252500001"
      state = "Disabled"
    },
    {
      id    = "252500002"
      state = "Enabled"
    }
  ]

  traffic_bypass = [
    {
      name                  = "bypass-http"
      protocol              = "TCP"
      description           = "Bypass HTTP traffic"
      destination_addresses = ["20.10.10.10"]
      destination_ip_groups = []
      destination_ports     = ["80"]
      source_addresses      = ["10.0.1.0/24"]
      source_ip_groups      = []
    }
  ]
}

threat_intelligence_allowlist = {
  fqdns        = ["safe.example.com"]
  ip_addresses = ["203.0.113.10"]
}

explicit_proxy = {
  enabled         = true
  http_port       = 3128
  https_port      = 3129
  enable_pac_file = true
  pac_file_port   = 8080
  pac_file        = "http://myproxy.example.com/proxy.pac"
}

tags = {
  environment = "dev"
  project     = "network-security"
}

```