provider "aws" {
	region = "us-west-1"
}

resource "aws_instance" "example" {
	ami = "ami-0d382e80be7ffdae5"
	instance_type = "t2.micro"
	vpc_security_group_ids = [aws_security_group.example-1.id]
	user_data = <<-EOF
			#!/bin/bash
			echo "Hello, World!" > index.html
			nohup busybox httpd -f -p 8080 &
			EOF
	tags = {
		Name = "test-server"
	}
}

resource "aws_security_group" "example-1" {
	name = "example-1"
	vpc_id = "vpc-b2dc7bd4"

	ingress {
		from_port = 8080
		to_port = 8080
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
		ipv6_cidr_blocks = ["::/0"]
	}
}
