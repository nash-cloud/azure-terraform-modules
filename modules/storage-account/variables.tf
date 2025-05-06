variable "basename" {
  type        = string
  description = "Basename of the module."
  validation {
    condition     = can(regex("^[0-9a-z]{1,22}$", var.basename))
    error_message = "The name must be betwen 1 and 22 characters, can only contain lowercase letters and  numbers."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name."
  validation {
    condition     = can(regex("^[-\\w\\.\\(\\)]{1,90}$", var.resource_group_name)) && can(regex("[-\\w\\(\\)]+$", var.resource_group_name))
    error_message = "Resource group names must be between 1 and 90 characters and can only include alphanumeric, underscore, parentheses, hyphen, period (except at end)."
  }
}

variable "location" {
  type        = string
  description = "Location of the resource group."
}

variable "account_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account. R"
  validation {
    condition     = contains(["standard", "premium"], lower(var.account_tier))
    error_message = "Supported values for account_tier are \"standard\" or \"premium\"."
  }
  default = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "Defines the type of replication to use for this storage account. R"
  validation {
    condition     = contains(["lrs", "grs", "ragrs", "zrs", "gzrs", "ragzrs"], lower(var.account_replication_type))
    error_message = "Supported values for account_replication_type are \"LRS\", \"GRS\", \"RAGRS\", \"ZRS\", \"GZRS\", \"RAGZRS\"."
  }
  default = "LRS"
}

variable "account_kind" {
  type        = string
  description = "Defines the Kind of account. R"
  validation {
    condition     = contains(["blobstorage", "blockblobstorage", "filestorage", "storage", "storagev2"], lower(var.account_kind))
    error_message = "Supported values for account_kind are \"BlobStorage\", \"BlockBlobStorage\", \"FileStorage\", \"Storage\", or \"StorageV2\"."
  }
  default = "StorageV2"
}

variable "hns_enabled" {
  type        = bool
  description = "Hierarchical namespaces enabled/disabled."
  default     = true
}

variable "min_tls_version" {
  type        = string
  description = "The minimum supported TLS version for the storage account. optional"
  validation {
    condition     = contains(["tls1_0", "tls1_1", "tls1_2"], lower(var.min_tls_version))
    error_message = "Valid values for min_tls_version are \"TLS1_0\", \"TLS1_1\", or \"TLS1_2\"."
  }
  default = "TLS1_2"
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether or not public network access is allowed for this resource."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags which should be assigned to the Resource Group. Optional"
  default     = {}
}

variable "module_enabled" {
  type        = bool
  description = "Variable to enable or disable the module. Optional"
  default     = true
}

# "network_rules" block variables
variable "firewall_default_action" {
  type        = string
  description = "Specifies the default action of allow or deny when no other rules match. Required"
  validation {
    condition     = contains(["allow", "deny"], lower(var.firewall_default_action))
    error_message = "Valid values for firewall_default_action are \"Allow\" or \"Deny\"."
  }
  default = "Deny"
}

variable "firewall_ip_rules" {
  type        = list(string)
  description = "List of public IP or IP ranges in CIDR Format. optional"
  default     = []
}

variable "firewall_virtual_network_subnet_ids" {
  type        = list(string)
  description = "A list of virtual network subnet ids to secure the storage account. optional"
  default     = []
}

variable "firewall_bypass" {
  type        = list(string)
  description = "Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. optional"
  validation {
    condition     = alltrue([for v in var.firewall_bypass : contains(["logging", "metrics", "azureservices", "none"], lower(v))])
    error_message = "Valid values for firewall_bypass are \"Logging\", \"Metrics\", \"AzureServices\" or \"None\"."
  }
  default = ["AzureServices"]
}

# Define the container names
variable "container_names" {
  type    = list(string)
  default = ["bronze", "silver", "gold"]
}


