provider "openstack" {
  cloud = var.cloud
}

provider "local" {}

locals {
  name-prefix = "tre_provisioner-${var.username}"
}

# Allocate floating IP

data "openstack_networking_network_v2" "external" {
  external = true
}

resource "openstack_networking_floatingip_v2" "floating-ip" {
  pool        = data.openstack_networking_network_v2.external.name
  description = "${local.name-prefix}-ip"
}

# Create SSH key

resource "openstack_compute_keypair_v2" "public-key" {
  name       = "${local.name-prefix}-key"
  public_key = chomp(file(pathexpand(var.key)))
}

# Create instance and assign IP

data "openstack_compute_flavor_v2" "flavour" {
  name = var.flavour
}

resource "openstack_compute_instance_v2" "instance" {
  name       = local.name-prefix
  flavor_id  = data.openstack_compute_flavor_v2.flavour.flavor_id
  image_name = var.image
  key_pair   = openstack_compute_keypair_v2.public-key.name

  security_groups = var.security-groups
  network { name = var.network }
}

resource "openstack_compute_floatingip_associate_v2" "floating-ip" {
  floating_ip = openstack_networking_floatingip_v2.floating-ip.address
  instance_id = openstack_compute_instance_v2.instance.id
}
