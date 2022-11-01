provider "aws" {
	region = "us-east-2"
}

resource "aws_instance" "example" {
	instance_type     = "t2.micro"
  ami               = "ami-0fb653ca2d3203ac1"

  tags = {
  	Name = "ernesto-reig-tf-test"
  }

}