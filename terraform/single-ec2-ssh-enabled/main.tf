provider "aws" {
    region = "us-east-1"
}

#preencher
locals {
  user_data = <<EOF
#!/bin/bash
echo "batata"
EOF
}

#preencher
resource "aws_key_pair" "accesskey" {
  key_name   = "access-key"
  public_key = "" //sua chave publica
}

resource "aws_instance" "aws_instance_suffix" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro" //free tier pq nao sou rico
  key_name = aws_key_pair.accesskey.key_name
  user_data_base64 = base64encode(local.user_data)
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
}

#raramente vai precisar mexer

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


data "aws_vpc" "default" {
  default = true
}