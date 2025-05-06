variable "basename" {
  type        = string
  description = "Basename of the module."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags which should be assigned to the deployed resource."
}

variable "module_enabled" {
  type        = bool
  description = "Variable to enable or disable the module."
  default     = true
}

variable "server_id" {
  type        = string
  description = "The id of the SQL Server on which to create the database."
}

variable "collation" {
  type        = string
  description = "The name of the collation."
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "sku_name" {
  type        = string
  description = "The name of the SKU."
  validation {
    condition     = contains(["Basic", "Standard", "Premium", "DataWarehouse", "GeneralPurpose", "Hyperscale"], var.sku_name)
    error_message = "Valid values for sku_name are \"Basic\", \"Standard\", \"Premium\", \"DataWarehouse\", \"GeneralPurpose\", or \"Hyperscale\"."
  }
  default = "Basic"
}

variable "max_storage" {
  type        = string
  description = "The maximum storage capacity expressed in GB."
  default     = "2"
}

variable "geo_backup_enabled" {
  type        = bool
  description = "Whether or not to enable geo-backup."
  default     = false
}