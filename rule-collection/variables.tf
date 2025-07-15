variable "firewall_policy_id" {
  description = "The ID of the Firewall Policy"
  type        = string
}

variable "rule_collection_groups" {
  description = "Map of Firewall Policy Rule Collection Groups"
  type = map(object({
    priority = number
    name     = string

    application_rule_collections = optional(list(object({
      name     = string
      priority = number
      action   = string
      rules = list(object({
        name              = string
        source_addresses  = list(string)
        destination_fqdns = list(string)
        protocols = list(object({
          type = string
          port = number
        }))
      }))
    })))

    network_rule_collections = optional(list(object({
      name     = string
      priority = number
      action   = string
      rules = list(object({
        name                  = string
        protocols             = list(string)
        source_addresses      = list(string)
        destination_addresses = list(string)
        destination_ports     = list(string)
      }))
    })))

    nat_rule_collections = optional(list(object({
      name     = string
      priority = number
      action   = string
      rules = list(object({
        name                = string
        protocols           = list(string)
        source_addresses    = list(string)
        destination_address = string
        destination_ports   = list(string)
        translated_address  = string
        translated_port     = string
      }))
    })))
  }))
}
