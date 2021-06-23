infrastructure:
	$(MAKE) -C $@

destroy:
	$(MAKE) -C infrastructure $@

.PHONY: infrastructure destroy
