output "rule_collection_group_ids" {
  description = "Map of Firewall Rule Collection Group resource IDs."
  value = {
    for k, v in azurerm_firewall_policy_rule_collection_group.main : k => v.id
  }
}