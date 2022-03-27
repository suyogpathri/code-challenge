all: clean apply

init:
	terraform init
	terraform get

plan: validate
	terraform plan -var-file="cc-uat.tfvars" -out=tf.plan

apply: plan
	terraform apply tf.plan

clean:
	rm -f tf.plan
	rm -rf .terraform
	rm -rf *.tfstate*

validate: init
	terraform validate

destroy:
	terraform destroy --var-file="cc-uat.tfvars"