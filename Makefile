.DEFAULT_GOAL := explain

.PHONY: explain
explain:
	@echo personalWebsite
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage: \033[36m\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: setup
setup: ## Install pre-commit hooks
	@pre-commit install

.PHONY: run
run: ## Run all pre-commit hooks
	@pre-commit run --all-files

.PHONY: deploy
deploy: ## Deploy or Update CloudFormation stack
	@aws cloudformation deploy \
		--template-file ./cloudFormation/s3Backend.yaml \
		--stack-name s3BackendTerraform \
		--region eu-west-2

.PHONY: init
init: ## Initialise terraform
	@terraform -chdir=terraform init

.PHONY: plan
plan: ## Plan terraform
	@terraform -chdir=terraform plan

.PHONY: apply
apply: ## Apply terraform
	@terraform -chdir=terraform apply

.PHONY: checkov
checkov: ## Run checkov
	@checkov --directory=cloudFormation
	@checkov --directory=terraform
