# terraform/versions.tf

terraform {
  required_version = ">= 1.6.0"

  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      # Força uma versão que seja mais recente e compatível
      version = ">= 2.7.0"
    }
  }
}