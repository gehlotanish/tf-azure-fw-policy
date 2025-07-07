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
| <a name="input_application_rule_collections"></a> [application\_rule\_collections](#input\_application\_rule\_collections) | List of application rule collections. | `any` | `[]` | no |
| <a name="input_explicit_proxy"></a> [explicit\_proxy](#input\_explicit\_proxy) | Explicit proxy configuration. | `any` | `null` | no |
| <a name="input_firewall_name"></a> [firewall\_name](#input\_firewall\_name) | Name for the Azure Firewall resource. | `string` | n/a | yes |
| <a name="input_firewall_policy_dns"></a> [firewall\_policy\_dns](#input\_firewall\_policy\_dns) | DNS settings block for the Firewall Policy. | `any` | `null` | no |
| <a name="input_firewall_policy_name"></a> [firewall\_policy\_name](#input\_firewall\_policy\_name) | Name for the Azure Firewall Policy. | `string` | n/a | yes |
| <a name="input_firewall_policy_sku"></a> [firewall\_policy\_sku](#input\_firewall\_policy\_sku) | SKU tier for the Azure Firewall Policy. | `string` | `"Standard"` | no |
| <a name="input_intrusion_detection"></a> [intrusion\_detection](#input\_intrusion\_detection) | Intrusion detection configuration for the Firewall Policy. | `any` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region for resource deployment. | `string` | n/a | yes |
| <a name="input_nat_rule_collections"></a> [nat\_rule\_collections](#input\_nat\_rule\_collections) | List of NAT rule collections. | `any` | `[]` | no |
| <a name="input_network_rule_collections"></a> [network\_rule\_collections](#input\_network\_rule\_collections) | List of network rule collections. | `any` | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group where resources will be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to resources. | `map(string)` | `{}` | no |
| <a name="input_threat_intelligence_allowlist"></a> [threat\_intelligence\_allowlist](#input\_threat\_intelligence\_allowlist) | Threat intelligence allowlist configuration. | `any` | `null` | no |
| <a name="input_threat_intelligence_mode"></a> [threat\_intelligence\_mode](#input\_threat\_intelligence\_mode) | Threat intelligence mode for the Firewall Policy. | `string` | `"Alert"` | no |  
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firewall_policy_base_policy_id"></a> [firewall\_policy\_base\_policy\_id](#output\_firewall\_policy\_base\_policy\_id) | ID of the Azure Firewall Policy. |
| <a name="output_firewall_policy_id"></a> [firewall\_policy\_id](#output\_firewall\_policy\_id) | ID of the Azure Firewall Policy. |
<!-- END_TF_DOCS -->

## Usage

```
location            = "eastus"
resource_group_name = "rg-fw-prod"
firewall_name       = "azfw-prod"
firewall_policy_name = "azfw-policy-prod"
firewall_policy_sku  = "Standard"
threat_intelligence_mode = "Alert"

tags = {
  environment = "prod"
  team        = "network"
}

# Optional DNS settings for the firewall policy
firewall_policy_dns = {
  proxy_enabled = true
  servers       = ["8.8.8.8", "1.1.1.1"]
}

# Intrusion detection configuration
intrusion_detection = {
  mode           = "Alert"
  private_ranges = ["10.0.0.0/8"]

  signature_overrides = [
    {
      id    = "252500001"
      state = "Disabled"
    }
  ]

  traffic_bypass = [
    {
      name                  = "BypassHttp"
      protocol              = "TCP"
      description           = "Bypass HTTP traffic"
      destination_addresses = ["0.0.0.0/0"]
      destination_ports     = ["80"]
      source_addresses      = ["10.0.1.0/24"]
    }
  ]
}

# Threat intelligence allowlist
threat_intelligence_allowlist = {
  fqdns        = ["example.com", "test.internal"]
  ip_addresses = ["192.0.2.10", "198.51.100.15"]
}

# Explicit proxy config
explicit_proxy = {
  enabled         = true
  http_port       = 8080
  https_port      = 8443
  enable_pac_file = true
  pac_file_port   = 8090
  pac_file        = "http://myproxy.example.com/proxy.pac"
}

# Network Rule Collections
network_rule_collections = [
  {
    name     = "Allow-DNS"
    priority = 100
    action   = "Allow"
    rules = [
      {
        name                  = "AllowDNSRule"
        source_addresses      = ["10.0.0.0/24"]
        destination_addresses = ["8.8.8.8"]
        destination_fqdns     = []
        destination_ports     = ["53"]
        protocols             = ["UDP"]
      }
    ]
  }
]

# Application Rule Collections
application_rule_collections = [
  {
    name     = "AllowWeb"
    priority = 200
    action   = "Allow"
    rules = [
      {
        name             = "AllowWebTraffic"
        source_addresses = ["10.0.1.0/24"]
        target_fqdns     = ["www.google.com", "www.bing.com"]
        protocols = [
          {
            port = 443
            type = "Https"
          },
          {
            port = 80
            type = "Http"
          }
        ]
      }
    ]
  }
]

# NAT Rule Collections
nat_rule_collections = [
  {
    name     = "DNAT-SSH"
    priority = 300
    action   = "Dnat"
    rules = [
      {
        name                  = "DNAT-SSH-Rule"
        source_addresses      = ["203.0.113.0/24"]
        destination_ports     = ["22"]
        destination_addresses = ["198.51.100.10"]
        translated_address    = "10.0.2.10"
        translated_port       = "22"
        protocols             = ["TCP"]
      }
    ]
  }
]

```