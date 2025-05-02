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