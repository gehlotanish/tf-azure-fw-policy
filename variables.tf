variable "resource_group_name" {
  description = "Name of the resource group where resources will be created."
  type        = string
}

variable "location" {
  description = "Azure region for resource deployment."
  type        = string
}

variable "firewall_policy_name" {
  description = "Name for the Azure Firewall Policy."
  type        = string
}


variable "firewall_policy_sku" {
  description = "SKU tier for the Azure Firewall Policy."
  type        = string
  default     = "Standard"
}

variable "threat_intelligence_mode" {
  description = "Threat intelligence mode for the Firewall Policy."
  type        = string
  default     = "Alert"
}

variable "firewall_policy_dns" {
  description = "DNS settings block for the Firewall Policy."
  type        = any
  default     = null
}

variable "intrusion_detection" {
  description = "Intrusion detection configuration for the Firewall Policy."
  type        = any
  default     = null
}

variable "threat_intelligence_allowlist" {
  description = "Threat intelligence allowlist configuration."
  type        = any
  default     = null
}

variable "explicit_proxy" {
  description = "Explicit proxy configuration."
  type        = any
  default     = null
}


variable "network_rule_collections" {
  description = "List of network rule collections."
  type        = any
  default     = []
}

variable "application_rule_collections" {
  description = "List of application rule collections."
  type        = any
  default     = []
}

variable "nat_rule_collections" {
  description = "List of NAT rule collections."
  type        = any
  default     = []
}

variable "firewall_name" {
  description = "Name for the Azure Firewall resource."
  type        = string
}


variable "tags" {
  description = "Additional tags to apply to resources."
  type        = map(string)
  default     = {}
}

