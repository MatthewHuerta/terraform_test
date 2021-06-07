provider "aws" {
	region = "us-west-1"
}

resource "aws_instance" "example" {
	ami = "ami-04468e03c37242e1e"
	instance_type = "t2.micro"
	tags = {
		Name = "test-server"
	}
}
