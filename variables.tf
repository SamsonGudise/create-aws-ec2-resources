variable "project_name" { default = "sarithm_sample" }
variable "region" { default = "us-west-2" }
variable "vpc_id" { }
variable "domainname" { default = "dev.sarithm.com" }
variable "app_name"  { default = "web" }
variable "idle_timeout" { default = 300 }
variable "ssl_cert"  {
	type = "map"
	default =  {
		"dev.sarithm.com"  = "arn:aws:acm:us-west-2:*"
	}
}
