service = jmeter
env     = lab
project = devops

export AWS_DEFAULT_REGION=us-east-1

base:
	@cd terraform/base/ && terraform init
	@cd terraform/base/ && terraform apply -var "service=${service}" -var "env=${env}" -var "project=${project}"

build:
	@packer init config.pkr.hcl
	@packer build -var "name=${project}-${env}-${service}" -var "role_type=${role_type}" config.pkr.hcl

destroy:
	@cd terraform/base/ && terraform destroy -var "service=${service}" -var "env=${env}" -var "project=${project}"