# Solita TRE Provisioning Machine Building

Build a machine in the Sanger OpenStack environment to install and
manage the Solita TRE.

## Dependencies

* GNU Make
* Terraform 1.0 – [download](https://developer.hashicorp.com/terraform/downloads)
  * OpenStack provider 1.42
  * Local provider 2.1.0
  * (these providers are installed automatically)
* Ansible 2.11 – `pip3 install ansible ansible-core==2.11 'Jinja2<3.1'` (https://github.com/ansible/ansible/issues/77413)
  * [`ansible.posix` module 1.2.0](https://galaxy.ansible.com/ansible/posix) – `ansible-galaxy collection install ansible.posix:1.2.0`
* OpenStack `clouds.yaml` for API access (this can be downloaded from `API Access` -> `Download OpenStack RC File`). This must be saved at `~/.config/openstack/clouds.yaml`

## Initial Configuration

### Ansible Vars

You will need to create an `ansible/vars.yml` file, that contains:

* The Git branch of the TRE repository to check out;
* The Google Cloud master and container project names;
* The container registry service account and key file;
* Your GitHub username and authentication token. (A token can be generated under your GH settings -> Developer Settings -> Personal Access Tokens)

**Note** You may also set arbitrary environment variables in this
configuration, under `tre.environment`. Useful variables include
`FINNGEN_ENVIRONMENT` and `FINNGEN_SANDBOX_ID`, which will avoid the
need to set these in the TRE's `make` targets. However, they are
optional, if you would rather be explicit.

An example file can be found in `ansible/vars.yml.example`.

**Ensure the indentation is correct in this file**

**Warning:** Do not check `ansible/vars.yml` or any Google Cloud service
account keys in!

### OpenStack `clouds.yaml`

- The key labelled `openstack` (under `clouds`) must be renamed to the tenant you wish to use.
- You must also add your openstack password as a key below your username, i.e.
```yml
user: username
password: openstack-password
```

### SSH

You'll need to have a `.ssh/id_rsa` and `.ssh/id_rsa.pub` file which will be
what you'll be able to use to access the new machine. Alternatively you can set
the `key` Terraform variable, e.g. to `~/.ssh/id_ed25519.pub`.

The username for SSH is hardcoded in the base image (such as `ubuntu` - this
should really be changed)

### Terraform

You can change the tenant being used in `infrastructure/variables.tf` file, and the instance name in `infrastructure/main.tf` (by default, it is based on your current username).

## Usage

Once your configuration is complete you may build the infrastructure and
provision the machine with:

    make

It is likely to take several minutes (in particular, Ansible may appear to hang
at "Wait for any unattended upgrade to finish" for five minutes or more).

The TRE codebase is checked out into `~/finngen`, at the branch declared
in `ansible/vars.yml`.

**Note:** While Google Cloud credentials are set up automatically on the
provisioning machine, you will have to manually authenticate yourself
for all Google Cloud processes:

    gcloud auth login

**Note:** The Kubernetes credentials are not automatically set up on the
provisioning machine. These can be acquired, if they exist, using the
`get-k8s-credentials` make target in the `iac/master` directory of the
TRE's codebase.

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

**Note:** The public SSH key is given as a variable, but the private key
also needs to exist. It is assumed to have the same filename, with the
`.pub` suffix stripped off.
