resource "azurerm_firewall_policy" "main" {
  name                     = var.firewall_policy_name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  sku                      = var.firewall_policy_sku
  threat_intelligence_mode = var.threat_intelligence_mode

  dynamic "dns" {
    for_each = var.firewall_policy_dns != null ? [var.firewall_policy_dns] : []
    content {
      proxy_enabled = dns.value.proxy_enabled
      servers       = dns.value.servers
    }
  }

  dynamic "intrusion_detection" {
    for_each = var.intrusion_detection != null ? [var.intrusion_detection] : []
    content {
      mode           = intrusion_detection.value.mode
      private_ranges = intrusion_detection.value.private_ranges

      dynamic "signature_overrides" {
        for_each = intrusion_detection.value.signature_overrides != null ? intrusion_detection.value.signature_overrides : []
        content {
          id    = signature_overrides.value.id
          state = signature_overrides.value.state
        }
      }

      dynamic "traffic_bypass" {
        for_each = intrusion_detection.value.traffic_bypass != null ? intrusion_detection.value.traffic_bypass : []
        content {
          name                  = traffic_bypass.value.name
          protocol              = traffic_bypass.value.protocol
          description           = traffic_bypass.value.description
          destination_addresses = traffic_bypass.value.destination_addresses
          destination_ports     = traffic_bypass.value.destination_ports
          source_addresses      = traffic_bypass.value.source_addresses
        }
      }
    }
  }

  dynamic "threat_intelligence_allowlist" {
    for_each = var.threat_intelligence_allowlist != null ? [var.threat_intelligence_allowlist] : []
    content {
      fqdns        = threat_intelligence_allowlist.value.fqdns
      ip_addresses = threat_intelligence_allowlist.value.ip_addresses
    }
  }

  dynamic "explicit_proxy" {
    for_each = var.explicit_proxy != null ? [var.explicit_proxy] : []
    content {
      enabled         = explicit_proxy.value.enabled
      http_port       = explicit_proxy.value.http_port
      https_port      = explicit_proxy.value.https_port
      enable_pac_file = explicit_proxy.value.enable_pac_file
      pac_file_port   = explicit_proxy.value.pac_file_port
      pac_file        = explicit_proxy.value.pac_file
    }
  }

  tags = var.tags
}

resource "azurerm_firewall_network_rule_collection" "main" {
  for_each            = try({ for collection in var.network_rule_collections : collection.name => collection }, toset([]))
  name                = each.key
  azure_firewall_name = var.firewall_name
  resource_group_name = var.resource_group_name
  priority            = each.value.priority
  action              = each.value.action

  dynamic "rule" {
    for_each = each.value.rules
    content {
      name                  = rule.value.name
      source_addresses      = rule.value.source_addresses
      destination_addresses = rule.value.destination_addresses
      destination_fqdns     = rule.value.destination_fqdns
      destination_ports     = rule.value.destination_ports
      protocols             = rule.value.protocols
    }
  }
}

resource "azurerm_firewall_application_rule_collection" "main" {
  for_each            = try({ for collection in var.application_rule_collections : collection.name => collection }, toset([]))
  name                = each.key
  azure_firewall_name = var.firewall_name
  resource_group_name = var.resource_group_name
  priority            = each.value.priority
  action              = each.value.action

  dynamic "rule" {
    for_each = each.value.rules
    content {
      name             = rule.value.name
      source_addresses = rule.value.source_addresses
      target_fqdns     = rule.value.target_fqdns

      dynamic "protocol" {
        for_each = rule.value.protocols
        content {
          port = protocol.value.port
          type = protocol.value.type
        }
      }
    }
  }
}

resource "azurerm_firewall_nat_rule_collection" "main" {
  for_each            = try({ for collection in var.nat_rule_collections : collection.name => collection }, toset([]))
  name                = each.key
  azure_firewall_name = var.firewall_name
  resource_group_name = var.resource_group_name
  priority            = each.value.priority
  action              = each.value.action

  dynamic "rule" {
    for_each = each.value.rules
    content {
      name                  = rule.value.name
      source_addresses      = rule.value.source_addresses
      destination_ports     = rule.value.destination_ports
      destination_addresses = rule.value.destination_addresses
      translated_address    = rule.value.translated_address
      translated_port       = rule.value.translated_port
      protocols             = rule.value.protocols
    }
  }
}