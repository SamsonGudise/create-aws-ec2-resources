resource  aws_instance example {
	ami = "ami-efd0428f"
	instance_type = "t2.micro"
	iam_instance_profile = "CodeDeployDemo-EC2-Instance-Profile"
	subnet_id = "subnet-4aa45212"
	key_name = "rhlinux"
	associate_public_ip_address = true
	security_groups = [ "sg-fdae4086" ]
	user_data	= "userdata.sh"
}
#"vpc-860089e2
