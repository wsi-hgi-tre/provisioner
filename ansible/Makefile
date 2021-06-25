ANSIBLE = ansible-playbook

ENTRY_SRC = main.yml
INVENTORY = inventory
VARIABLES = vars.yml
SOURCES = $(shell find roles -type f)

all: $(ENTRY_SRC) $(SOURCES) $(INVENTORY) $(VARIABLES)
	$(ANSIBLE) $(ENTRY_SRC) \
	           -i "$(INVENTORY)" \
	           -e "ansible_python_interpreter=/usr/bin/python3" \
	           -e "@$(VARIABLES)"

$(INVENTORY):
	@echo "Ansible inventory does not exist; create the infrastructure first"
	@exit 1

$(VARIABLES):
	@echo "You must set the Ansible variables; see vars.yml.example for details"
	@exit 1

.PHONY: all
