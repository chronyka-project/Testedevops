# terraform/variables.tf

# Variáveis para o Provider (Secrets)
variable "vsphere_user" {
  description = "vCenter username"
  type        = string
}

variable "vsphere_password" {
  description = "vCenter password"
  type        = string
  sensitive   = true 
}

variable "vsphere_server" {
  description = "vCenter Server hostname or IP"
  type        = string
}

variable "vsphere_allow_unverified_ssl" {
  description = "Permitir certificados auto-assinados"
  type        = bool
  default     = true
}

# Variáveis para o Ambiente vSphere
variable "vsphere_datacenter" { type = string }
variable "vsphere_cluster"    { type = string }
variable "vsphere_datastore"  { type = string }
variable "vsphere_network"    { type = string }
variable "vm_template"        { type = string }

# Variáveis para a VM
variable "vm_name"      { type = string }
variable "vm_domain"    { type = string }
variable "vm_cpu"       { type = number }
variable "vm_memory"    { type = number }
variable "vm_ip"        { type = string }
variable "vm_netmask"   { type = number }
variable "vm_gateway"   { type = string }