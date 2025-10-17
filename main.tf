terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~> 2.6"
    }
  }
}

provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server
  allow_unverified_ssl = true
}

# --- VARIÁVEIS ---
variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}

variable "datacenter" {
  default = "Datacenter"
}

variable "resource_pool" {
  default = "Resources" # Default pool se não houver cluster
}

variable "datastore" {
  default = "datastore1"
}

variable "network" {
  default = "VM Network"
}

variable "template_name" {
  default = "debian11-template" # nome do seu template existente
}

variable "vm_name" {
  default = "tf-test-vm"
}

variable "vm_cpu" {
  default = 2
}

variable "vm_memory" {
  default = 2048
}

# --- RECURSOS ---
data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.template_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = var.resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.vm_cpu
  memory   = var.vm_memory
  guest_id = data.vsphere_virtual_machine.template.guest_id

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks[0].size
    eagerly_scrub    = false
    thin_provisioned = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = var.vm_name
        domain    = "local"
      }

      network_interface {
        ipv4_address = null
        ipv4_netmask = 24
      }

      ipv4_gateway = null
    }
  }
}

output "vm_name" {
  value = vsphere_virtual_machine.vm.name
}

output "vm_ip" {
  value = vsphere_virtual_machine.vm.default_ip_address
}
