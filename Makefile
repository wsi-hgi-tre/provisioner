all: ansible

ansible: infrastructure
	$(MAKE) -C $@

infrastructure:
	$(MAKE) -C $@

destroy:
	$(MAKE) -C infrastructure $@

.PHONY: all infrastructure ansible destroy
