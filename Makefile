# Copyright (c) 2019, Digital Asset (Switzerland) GmbH and/or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

SHELL := /usr/bin/env bash
.SHELLFLAGS := -euo pipefail -c

daml := ~/.daml/bin/daml
sdk_version ?= $(shell cat daml.yaml | grep sdk-version | tr -d ' ' | cut -d':' -f2)

################
# sdk install
################

.PHONY: sdk
sdk: daml.yaml
	@echo install triggered because these files changed: $?
	$(daml) install $(sdk_version)

################
# dar pipeline
################

# test -> build

# results
dar_test_result := target/DarTests.xml
dar_build_result := target/finlib.dar

# source
damlsrc := daml


# dar test
.PHONY: test-dar
test-dar: sdk $(dar_test_result)

# TODO - move to junit files when new version of SDK comes out
$(dar_test_result): $(shell find $(damlsrc) -type f) daml.yaml
	@echo test triggered because these files changed: $?
	$(daml) test --junit $@


# dar build
.PHONY: build-dar
build-dar: $(dar_build_result)

$(dar_build_result): $(dar_test_result)
	@echo build triggered because these files changed: $?
	$(daml) build -o $@

########
# clean
########

.PHONY: clean
clean:
	-rm -vfr target/*
