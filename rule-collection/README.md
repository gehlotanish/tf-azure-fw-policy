## Usage

```
rule_collection_groups = {
  "example-fwpolicy-rcg" = {
    name = "fwpolicy"
    priority = 500

    application_rule_collections = [
      {
        name     = "app_rule_collection1"
        priority = 500
        action   = "Deny"
        rules = [
          {
            name              = "app_rule_collection1_rule1"
            source_addresses  = ["10.0.0.1"]
            destination_fqdns = ["*.microsoft.com"]
            protocols = [
              { type = "Http", port = 80 },
              { type = "Https", port = 443 }
            ]
          }
        ]
      }
    ]

    network_rule_collections = [
      {
        name     = "network_rule_collection1"
        priority = 400
        action   = "Deny"
        rules = [
          {
            name                  = "network_rule_collection1_rule1"
            protocols             = ["TCP", "UDP"]
            source_addresses      = ["10.0.0.1"]
            destination_addresses = ["192.168.1.1", "192.168.1.2"]
            destination_ports     = ["80", "1000-2000"]
          }
        ]
      }
    ]

    nat_rule_collections = [
      {
        name     = "nat_rule_collection1"
        priority = 300
        action   = "Dnat"
        rules = [
          {
            name                = "nat_rule_collection1_rule1"
            protocols           = ["TCP", "UDP"]
            source_addresses    = ["10.0.0.1", "10.0.0.2"]
            destination_address = "192.168.1.1"
            destination_ports   = ["80"]
            translated_address  = "192.168.0.1"
            translated_port     = "8080"
          }
        ]
      }
    ]
  }
}
```