plan: 
	terraform init
	terraform plan -out terraform.plan
apply:
	terraform apply terraform.plan
clean:
	rm -rf terraform.plan
