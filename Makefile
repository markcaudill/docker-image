SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --jobs=$(shell nproc)
MAKEFLAGS += --load-average=$(shell nproc)

# Commands
DOCKER = docker
SHELLCHECK = shellcheck

REPO = markcaudill
IMAGE = $(shell basename $$(pwd) | awk -F'-' '{print $$NF}')
TAG ?= dev
FULL_TAG = $(REPO)/$(IMAGE):$(TAG)


.PHONY: help
help :  ## This message
	@echo $(FULL_TAG)
	@echo
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Targets
.PHONY: image
image: test  ## Build image
	@echo "+ $@"
	$(DOCKER) build -t $(FULL_TAG) .

.PHONY: lint
lint: Dockerfile  ## Lint Dockerfile
	@echo "+ $@"
	$(DOCKER) run --rm -i hadolint/hadolint < $<

.PHONY: push
push: image  ## Push image
	@echo "+ $@"
	$(DOCKER) push $(FULL_TAG)

.PHONY: shellcheck
shellcheck: entrypoint.sh  ## Shellcheck entrypoint.sh
	@echo "+ $@"
	$(SHELLCHECK) $<

.PHONY: test
test: lint shellcheck  ## Test
	@echo "+ $@"
