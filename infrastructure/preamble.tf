terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.42.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.1.0"
    }
  }
  required_version = ">= 1.0"
}
