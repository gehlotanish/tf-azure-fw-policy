output "firewall_policy_id" {
  description = "ID of the Azure Firewall Policy."
  value       = azurerm_firewall_policy.main.id
}

output "firewall_policy_base_policy_id" {
  description = "ID of the Azure Firewall Policy."
  value       = azurerm_firewall_policy.main.base_policy_id
}
