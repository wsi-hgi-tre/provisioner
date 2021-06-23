TERRAFORM = terraform
TERRAFORM_INIT = .terraform
TERRAFORM_STATE = $(wildcard *.tfstate*)

SOURCES = $(shell find . -type f -name "*.tf")

all: $(SOURCES) $(TERRAFORM_INIT) apply

apply destroy:
	$(TERRAFORM) $@ -auto-approve \
	                -var "username=$$(whoami)"

$(TERRAFORM_INIT):
	$(TERRAFORM) init

clean:
	rm -rf $(TERRAFORM_INIT) $(TERRAFORM_STATE)

.PHONY: all apply destroy clean
