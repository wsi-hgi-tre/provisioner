output "ip" {
  value = openstack_networking_floatingip_v2.floating-ip.address
}

resource "local_file" "ansible_inventory" {
  filename        = "${path.root}/../ansible/inventory"
  file_permission = "0644"
  content         = templatefile("inventory.tpl", {
    floating_ip = openstack_networking_floatingip_v2.floating-ip.address
    username    = var.username
    private_key = trimsuffix(var.key, ".pub")
  })
}
