provider "aws" {
  region = "us-east-2"
  profile                  = "okta-elastic-dev"
}

variable "server_port" {
  description = "The http port to be used"
  type        = number
  default     = 8080
}

resource "aws_security_group" "sg" {

  name = "ernesto-reig-tf-test-sg"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
  instance_type     = "t2.micro"
  ami               = "ami-0fb653ca2d3203ac1"
  vpc_security_group_ids = [aws_security_group.sg.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port}
              EOF

  user_data_replace_on_change = true

  tags = {
    Name = "ernesto-reig-tf-test"
  }

}

output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP of the Instance"
}