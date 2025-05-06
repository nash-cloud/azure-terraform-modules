# Azure Terraform Modules

This repository contains reusable Terraform modules to provision the following Azure resources:

- Resource Group
- Storage Account
- Data Factory

## 🧱 Module Structure

```bash
azure-terraform-modules/
└── test/
    ├── main.tf                # Root module to call submodules
    ├── variables.tf           # Input variables (if needed at root level)
    ├── outputs.tf             # Output values from root
    ├── providers.tf           # Required provider and Terraform versions
    └── locals.tf                         
└── modules/
    ├── resource-group/
    ├── storage-account/
    ├── data-factory/
    ├── sql-server/
    ├── sql-database/
    └── user-assigned-identity/
    
````

## 🚀 Getting Started

### Prerequisites

* [Terraform](https://www.terraform.io/downloads.html) >= 1.0
* [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
* An Azure subscription

### Initialize and Deploy (Instructions)
- Clone the [repo](https://github.com/nash-cloud/azure-terraform-modules.git)
- Copy terraform.tfvars.example to terraform.tfvars
- Update terraform.tfvars with your desired values
- Run Terraform

```bash
# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Preview the changes
terraform plan

# Apply the changes
terraform apply
```

## 🔐 Security Notes


## 📦 Modules Overview

### Resource Group

```hcl
module "resource_group" {
  source   = "../modules/resource-group"
  name     = "rg-demo"
  location = "East US"
}
```

### Storage Account

```hcl
module "storage_account" {
  source              = "../modules/storage-account"
  name                = "storageacctdemo123"
  resource_group_name = module.resource_group.name
  location            = "East US"
}
```

### Data Factory

```hcl
module "data_factory" {
  source              = "../modules/data-factory"
  name                = "datafactorydemo"
  resource_group_name = module.resource_group.name
  location            = "East US"
}
```

## 📝 License

This project is licensed under the MIT License.
