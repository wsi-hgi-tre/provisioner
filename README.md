# Solita TRE Provisioning Machine Building

Build a machine in the Sanger OpenStack environment to install and
manage the Solita TRE.

## Dependencies

* GNU Make
* Terraform 1.0
  * OpenStack provider 1.42
  * Local provider 2.1.0
* Ansible 2.11
  * [`ansible.posix` module 1.2.0](https://galaxy.ansible.com/ansible/posix)
* OpenStack `clouds.yaml` for API access

## Initial Configuration

You will need to create an `ansible/vars.yml` file, that contains:

* The TRE's GitHub repository;
* The branch of this repository;
* Your GitHub username (to clone the TRE repository);
* Your GitHub password or authentication token.

An example file can be found in `ansible/vars.yml.example`.

**Warning** Do not check `ansible/vars.yml` in!

## Usage

Once your configuration is complete you may build the infrastructure and
provision the machine with:

    make

To destroy the infrastructure:

    make destroy

## Infrastructure Customisation

The infrastructure is built with Terraform from the `infrastructure`
directory. The `variables.tf` file outlines what variables can be set;
all of them have Sanger/HGI defaults -- besides the username, which is
determined at runtime -- but they can be overridden manually, rather
than running the `Makefile`.

**Note** The public SSH key is given as a variable, but the private key
also needs to exist. It is assumed to have the same filename, with the
`.pub` suffix stripped off.
