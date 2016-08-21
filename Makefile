.PHONY: help
.DEFAULT_GOAL := help

help: ## Display help
		@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build:
	cd scientific-$(v) && packer build template.json

verify:
	cd scientific-$(v)/artifacts && vagrant box add sl$(v) scientific-linux-$(v)-x64_virtualbox.box
	cd scientific-$(v)/artifacts && vagrant init sl$(v)
	cd scientific-$(v)/artifacts && vagrant up
	cd scientific-$(v)/artifacts && vagrant ssh -c 'cat /etc/system-release'

push:
	cd scientific-$(v) && packer push template.json
