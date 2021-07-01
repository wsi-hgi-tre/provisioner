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

* The Git branch of the TRE repository to check out;
* The Google Cloud master and container project names;
* The container registry service account and key file;
* Your GitHub username and password/authentication token.

**Note** You may also set arbitrary environment variables in this
configuration, under `tre.environment`. Useful variables include
`FINNGEN_ENVIRONMENT` and `FINNGEN_SANDBOX_ID`, which will avoid the
need to set these in the TRE's `make` targets. However, they are
optional, if you would rather be explicit.

An example file can be found in `ansible/vars.yml.example`.

**Warning** Do not check `ansible/vars.yml` or any Google Cloud service
account keys in!

## Usage

Once your configuration is complete you may build the infrastructure and
provision the machine with:

    make

The TRE codebase is checked out into `~/finngen`, at the branch declared
in `ansible/vars.yml`.

To push an image from DockerHub into the Google Cloud container
registry, run from within the built provisioning machine:

    ./docker-dance.sh IMAGE [GCR_IMAGE]

Where `IMAGE` is the full image name and tag you wish to use (e.g.,
`ubuntu:latest`). The Google Cloud image will be given the same `IMAGE`
name, but this can be overridden by specifying a `GCR_IMAGE` argument.

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
