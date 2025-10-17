# terraform/main.tf

# Este bloco deve conter a configuração do provider vsphere
provider "vsphere" {
  user                   = var.vsphere_user
  password               = var.vsphere_password
  vsphere_server         = var.vsphere_server
  allow_unverified_ssl = var.vsphere_allow_unverified_ssl
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.vm_cpu
  memory   = var.vm_memory
  guest_id = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "${var.vm_name}-disk0"
    size             = data.vsphere_virtual_machine.template.disks[0].size
    eagerly_scrub    = false
    thin_provisioned = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = var.vm_name
        domain    = var.vm_domain
      }

      network_interface {
        ipv4_address = var.vm_ip
        ipv4_netmask = var.vm_netmask
      }

      ipv4_gateway = var.vm_gateway
    }
  }
}

# RECURSO PARA CHAMAR O ANSIBLE APÓS A CRIAÇÃO DA VM
resource "null_resource" "ansible_provisioning" {
  # Garante que o Ansible só roda DEPOIS da VM ser criada (e clonada com o IP estático)
  depends_on = [vsphere_virtual_machine.vm]

  provisioner "local-exec" {
    # 💡 Usa o IP estático definido em var.vm_ip para o inventário
    # -u: Usuário para conexão SSH na VM
    # --private-key: Caminho da chave no Runner
    command = "ansible-playbook -i '${var.vm_ip},' --private-key ~/.ssh/id_rsa -u seu_usuario_ssh ../ansible/site.yml"
    
    # Define o diretório de trabalho como o diretório 'terraform/'
    working_directory = "${path.module}" 
  }
}