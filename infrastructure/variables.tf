variable "cloud" {
  description = "OpenStack cloud identifier, per clouds.yaml"
  type        = string
  default     = "hgi-dev"
}

variable "network" {
  description = "Network in which to create the provisioning machine"
  type        = string
  default     = "cloudforms_network"
}

variable "flavour" {
  description = "Machine flavour for the provisioning machine"
  type        = string
  default     = "m2.medium"
}

variable "image" {
  description = "Docker-enabled base Ubuntu Bionic image"
  type        = string
  default     = "bionic-WTSI-docker_73623_ce89d144"
}

variable "username" {
  description = "Username for the provisioning machine"
  type        = string
}

variable "key" {
  description = "Path to a public key file, for which its private key must exist"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "security-groups" {
  description = "Security groups assigned to the provisioning machine"
  type        = list(string)
  default     = ["cloudforms_ssh_in"]
}
