ANSIBLE = ansible-playbook

ENTRY_SRC = main.yml
INVENTORY = inventory
SOURCES = $(shell find . -type f)

all: $(ENTRY_SRC) $(SOURCES) $(INVENTORY)
	$(ANSIBLE) $(ENTRY_SRC) \
	           -i "$(INVENTORY)" \
	           -e "ansible_python_interpreter=/usr/bin/python3" \
	           -e "@vars.yml"

$(INVENTORY):
	@echo "Ansible inventory does not exist; create the infrastructure first"
	@exit 1

.PHONY: all
