.PHONY: help
SHELL:=/bin/bash
PROJECT_ROOT=$(shell pwd)

help:  ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

generate-cloud-init-config:  ## Generates the cloud init file
	./generate_cloud_init_file.sh ubuntu # -$(shell date +%Y%m%d%H%M%S)

create:  ## Create the VM and its associated resources on KVM
	terraform init && terraform plan && terraform apply

destroy:  ## Destroy the VM and its associated resources on KVM
	terraform destroy && rm terraform.tfstate*

status:  ## List the VM and its associated resources on KVM
	terraform refresh && terraform show
