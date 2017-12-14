resource  "aws_elb" "lb" {
	name = "${var.project_name}-${var.app_name}-lb"
	security_groups = ["${aws_security_group.web_traffic.id}"]
	subnets	= [ "${data.aws_subnet_ids.public.id}" ]
	cross_zone_load_balancing = true
	idle_timeout = "${var.idle_timeout}"

	listener  {
		instance_port = 80
		instance_protocol = "http"
		lb_port	 = 80
		lb_protocol = "http"
	}
	
	listener {
		instance_port = 8080
		instance_protocol = "http"
		lb_port	 = 443
		lb_protocol = "https"
#		ssl_certificate_id ="${lookup(var.ssl_cert,var.domainname)}"
	}
	
	health_check {
		healthy_threshold = 2
		unhealthy_threshold = 2
		timeout	= 3
		target = "TCP:80"
		interval = 30
	}
	
	tags {
		Name  = "${var.project_name}-${var.app_name}"
		Terraform = true
		Project = "${var.project_name}"
		app = "${var.app_name}"
	}
}

resource "aws_security_group"  "web_traffic" {
	name  = "web_traffic"
	description  = "web_traffic_public"
	vpc_id 	= "${var.vpc_id}"
	tags {
		Name	= "${var.project_name}-webtraffic"
		Terraform = true
		Project = "${var.project_name}"
	}
}

resource "aws_security_group_rule" "web_traffic_ingress_http" {
	type = "ingress"
	from_port = 80
	to_port = 80
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
	security_group_id = "${aws_security_group.web_traffic.id}"
}

resource "aws_security_group_rule" "web_traffic_ingress_https" {
	type = "ingress"
	from_port = 443
	to_port = 443
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
	security_group_id = "${aws_security_group.web_traffic.id}"
}

resource "aws_security_group_rule" "web_traffic_egress" {
	type = "egress"
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
	security_group_id = "${aws_security_group.web_traffic.id}"
}

