resource "random_string" "postfix" {
  length  = 8
  special = false
  upper   = false
}

variable "location" {
  type    = string
  default = "East US"
}

variable "subscription_id" {
  type    = string
  default = null
}

variable "module_enabled" {
  type        = bool
  description = "Variable to enable or disable the module."
  default     = true
}

# Storage account 
variable "hns_enabled" {
  type        = bool
  description = "Hierarchical namespaces enabled/disabled."
  default     = true
}

variable "firewall_default_action" {
  type        = string
  description = "Specifies the default action of allow or deny when no other rules match."
  default     = "Deny"
}

variable "firewall_ip_rules" {
  type        = list(string)
  description = "List of public IP or IP ranges in CIDR Format."
  default     = []
}

variable "firewall_bypass" {
  type        = list(string)
  description = "Specifies whether traffic is bypassed for Logging/Metrics/AzureServices."
  default     = ["AzureServices"]
}

# SQL server 
variable "db_version" {
  type        = string
  description = "The version of the sql server."
  default     = "12.0"
}

variable "sql_server_administrator_login" {
  type        = string
  description = "The administrator login name for the sql server."
  default     = null
}

variable "sql_server_administrator_password" {
  type        = string
  description = "The administrator password for the sql server."
  default     = null
}

variable "minimum_tls_version" {
  type        = string
  description = "The minimum TLS version."
  default     = "1.2"
}

# SQL Database 
variable "sku_name" {
  type        = string
  description = "The sku name."
  default     = "S0"
}

variable "geo_backup_enabled" {
  type        = bool
  description = "Geo backup enabled/disabled."
  default     = true
} 